!Text-based user interface
module ui
    use units
    implicit none

    character(maxlen), allocatable :: filenames(:)
    character(8) :: date
    character(6) :: time

    contains

    !Reads arguments (filenames) from user
    subroutine read_arguments()
        implicit none
        character(maxlen) :: arg
        integer :: i, iarg

        iarg = command_argument_count()
        
        if (iarg == 0) then
            call get_command_argument(0, arg)
            write(0, '(a,a,a)') 'usage: ', trim(arg), &
            ' input_file_1, input_file_2, ..., input_file_n'
            stop
        end if

        allocate(filenames(iarg))

        do i = 1, iarg
            call get_command_argument(i, arg)
            read(arg, *) filenames(i)
        end do
    end subroutine read_arguments

     !Writes info to screen
    subroutine print_info(time_simulated, num_steps, num_writes, N, objects)
        implicit none
        integer, intent(in) :: num_steps, num_writes, N
        type(object), intent(in) :: objects(N)
        real(rk), intent(in) :: time_simulated
        type(vector) :: r
        integer :: i

        print '(a, i0)', 'Number of objects: ', N
        
        print '(a, e12.6, x, a, a, i0)', 'Time and number of steps from the beginning of the simulation: t = ', &
        unit_conversion(time_simulated, default_units(1), units_used(1)), trim(unit_names(1)) , ',  n = ', num_steps
        
        print '(a, i0)', 'Number of iteration steps written to file: ', num_writes
        
        print '(7a)', 'Current positions of the objects [n, x(', trim(unit_names(2)), &
        '), y(', trim(unit_names(2)), '), z(', trim(unit_names(2)), ')]:'

        do i = 1, N
            r = vector_unit_conversion(objects(i)%pos, default_units(2), units_used(2))
            print '(i0, 4x, 3(e20.10, 4x))', i, r
        end do

        print *
    end subroutine print_info

    !Writes date and time to screen in format yy-mm-dd hr:min:sec
    subroutine print_time()
        implicit none
        character(maxlen) :: format

        call date_and_time(date, time)

        format = '(2(a, "-"), a, x, 2(a, ":"), a)'

        print format, date(1:4), date(5:6), date(7:8), time(1:2), time(3:4), time(5:6)
    end subroutine print_time
end module ui