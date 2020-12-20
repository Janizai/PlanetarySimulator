!Read from & write to files
module files
    use simulation, only : acceleration
    use units
    implicit none

    type(object), allocatable :: objects(:)
    real(rk) :: t, dt, m_step, k_step, params(5)
    integer :: N, simulation_end

    contains
    
        !Reads the input file
        subroutine read_from_file(filename)
            implicit none
            character(maxlen), intent(in) :: filename
            
            character(maxlen) :: skip_row
            integer :: i, ios

            open(unit = 1, file = filename, iostat = ios, status = 'old')

            if (ios /= 0) then
                print '(a, a)', 'Error in opening file ', trim(filename)
                stop
            end if

            read (1, *) skip_row 

            read (1, *) unit_names
            
            read (1, *) skip_row

            read (1, *) params
            
            read (1, *) skip_row

            N = int(params(1))
            allocate(objects(N))

            do i = 1, N
                objects(i)%num = i
                read(1, *, iostat = ios) objects(i)%mass, objects(i)%pos, objects(i)%vel
                objects(i)%acc = vector(0, 0, 0)

                if (ios /= 0) then
                    print '(a, a)', 'Error in reading file ', trim(filename)
                    print '(a, a)', 'Make sure that all input parameters have correct values.'
                    stop
                end if
            end do

            close(unit = 1, status = 'keep')

        end subroutine read_from_file

        !Assigns values for inputs
        subroutine assign_values(filename)
            implicit none
            character(maxlen), intent(in) :: filename
            real(rk) :: t
            integer :: i

            call read_from_file(filename)
            call unit_assignment()

            t = unit_conversion(params(2), units_used(1), default_units(1))
            dt = unit_conversion(params(3), units_used(1), default_units(1))
            m_step = int(params(4))
            k_step = int(params(5))
            simulation_end = nint(t / dt)
            
            !Convert units for objects
            do i = 1, N
                objects(i)%mass = unit_conversion(objects(i)%mass, units_used(3), default_units(3))
                
                objects(i)%pos = vector_unit_conversion(objects(i)%pos, units_used(2), default_units(2))

                objects(i)%vel = vector_unit_conversion(objects(i)%vel, &
                units_used(4) / units_used(5), default_units(4) / default_units(5))
            end do

            !Initial accelerations
            do i = 1, N
                objects(i)%acc = acceleration(N, i, objects)
            end do
        end subroutine assign_values

        !Writes positions to an output file
        subroutine write_to_file(filename, time_simulated)
            implicit none
            character(maxlen), intent(in) :: filename
            real(rk), intent(in) :: time_simulated
            
            type(vector) :: r
            integer :: i, ios
            logical :: file_exists
            real(rk) :: t

            inquire(file = filename, exist = file_exists)

            if (file_exists) then
                open(unit = 1, file = filename, iostat = ios, position = 'append', status = 'old')
            else
                open(unit = 1, file = filename, iostat = ios, status = 'new')
            end if

            if (ios /= 0) then
                print '(a,a)', 'Error in opening file ', trim(filename)
                stop
            end if

            do i = 1, N
                r = vector_unit_conversion(objects(i)%pos, default_units(2), units_used(2))
                t = unit_conversion(time_simulated, default_units(1), units_used(1))
                write(1, '(i0, 3(e20.10), e20.10)') i, r, t
            end do

            close(unit = 1, status = 'keep')
            
        end subroutine write_to_file

end module files