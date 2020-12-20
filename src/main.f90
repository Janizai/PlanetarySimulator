!The main program
program main
    use simulation, only : simulator
    use files
    use ui

    implicit none
    integer :: file_num, num_steps, num_writes
    real(rk) :: time_start, time_stop, time_simulated
    character(maxlen) :: filename, output_filename

    !Get input files
    call read_arguments()

    print '(/, 82("-"))'

    !Run simulation for all files one at a time
    do file_num = 1, size(filenames)
        filename = filenames(file_num)
        print '(/, a, a)', 'Using input file: ', filename
        
        call assign_values(filename)
        
        write(6, '(a)', advance = 'no') 'Time at the beginning of the simulation: '
        call print_time()
        call cpu_time(time_start)
        print *

        time_simulated = 0
        num_steps = 0
        num_writes = 0

       output_filename = filename(1 : len_trim(filename) - 4)//'_'//date//'_'//time//'_output.dat'

        !Simulation according to input parameters
        do num_steps = 0, simulation_end - 1
            if (mod(num_steps, int(k_step)) == 0) then
                call write_to_file(output_filename, time_simulated)
                num_writes = num_writes + 1
            end if

            if (mod(num_steps, int(m_step)) == 0) then
                call print_info(time_simulated, num_steps, num_writes, N, objects)
            end if

            call simulator(N, objects, dt)
            time_simulated = time_simulated + dt
        end do

        call write_to_file(output_filename, time_simulated)
        num_writes = num_writes + 1

        call print_info(time_simulated, num_steps, num_writes, N, objects)

        write(6, '(a)', advance = 'no') 'Time at the ending of the simulation: '
        call print_time()
        
        call cpu_time(time_stop)
        print '(a, f10.3)', 'CPU time spent (in seconds): ', time_stop - time_start
        
        print '(/, 82("-"), /)'

        deallocate(objects)
    end do

end program main