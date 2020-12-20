!Determines the units of the input file and performs unit conversions
module units
    use constants
    use types
    implicit none
    
    real(rk), parameter :: default_units(5) = [s, m, kg, m, s]
    character(5) :: unit_names(5)
    real(rk) :: units_used(5)

    contains

    !Converts a value given in unit_1 to a value given in unit_2
    real(rk) function unit_conversion(value, unit_1,  unit_2)
        implicit none
        real(rk), intent(in) :: value
        real(rk), intent(in) ::  unit_1, unit_2

        unit_conversion = value * unit_1 / unit_2

    end function unit_conversion

    !Converts a vector given in unit_1 to a vector given in unit_2
    type(vector) function vector_unit_conversion(value, unit_1, unit_2)
        implicit none
        type(vector), intent(in) :: value
        real(rk), intent(in) ::  unit_1, unit_2

        vector_unit_conversion = value * unit_1 / unit_2
    end function vector_unit_conversion

    !Tells the program what units the data uses
    subroutine unit_assignment()
        implicit none
        integer :: i

        if (any(units_time == unit_names(1))) then
            do i = 1, size(units_time)
                if (units_time(i) == unit_names(1)) units_used(1) = values_time(i)
            end do
        else
            print '(a, a, a, a)', 'Using an undefined unit of time: ', trim(unit_names(1))
            units_used(1) = default_units(1)
        end if
        
        if (any(units_dist == unit_names(2))) then
            do i = 1, size(units_dist)
                if (units_dist(i) == unit_names(2)) units_used(2) = values_dist(i)
            end do
        else
            print '(a, a, a, a)', 'Using an undefined unit of distance: ', trim(unit_names(2))
            units_used(2) = default_units(2)
        end if

        if (any(units_mass == unit_names(3))) then
            do i = 1, size(units_mass)
                if (units_mass(i) == unit_names(3)) units_used(3) = values_mass(i)
            end do
        else
            print '(a, a, a, a)', 'Using an undefined unit of mass: ', trim(unit_names(3))
            units_used(3) = default_units(3)
        end if

        if (any(units_dist == unit_names(4)) .and. any(units_time == unit_names(5))) then
            do i = 1, size(units_dist)
                if (units_dist(i) == unit_names(4)) units_used(4) = values_dist(i)
            end do
            do i = 1, size(units_time)
                if (units_time(i) == unit_names(5)) units_used(5) = values_time(i)
            end do
        else
            print '(a, a, x, a, a, a)', 'Using an undefined unit of velocity: ', &
            trim(unit_names(4)), trim(unit_names(5))
            units_used(4 : 5) = default_units(4 : 5)
        end if
    end subroutine unit_assignment
end module units