!Contains datatypes used by the program
module types
    use constants, only : rk, maxlen
    implicit none

    type :: vector
        real(rk) :: x, y, z
    end type vector

    type :: object
        type (vector) :: pos, vel, acc
        real(rk) :: mass
        integer :: num
    end type object

    interface operator(+)
        module procedure vadd
    end interface

    interface operator(-)
        module procedure vsub
    end interface

    interface operator(*)
        module procedure vpro1
        module procedure vpro2
        module procedure vdot
    end interface

    interface operator(/)
        module procedure vdiv
    end interface

    contains

    !Define vector addition
    type(vector) function vadd(v1, v2)
        implicit none
        type(vector), intent(in) :: v1, v2

        vadd%x = v1%x + v2%x
        vadd%y = v1%y + v2%y
        vadd%z = v1%z + v2%z
    end function vadd

    !Define vector subtraction
    type(vector) function vsub(v1, v2)
        implicit none
        type(vector), intent(in) :: v1, v2

        vsub%x = v1%x - v2%x
        vsub%y = v1%y - v2%y
        vsub%z = v1%z - v2%z
    end function vsub

    !Define vector product with a scalar
    type(vector) function vpro1(v, k_step)
        implicit none
        type(vector), intent(in) :: v
        real(rk), intent(in) :: k_step

        vpro1%x = v%x * k_step
        vpro1%y = v%y * k_step
        vpro1%z = v%z * k_step
    end function vpro1

    type(vector) function vpro2(k_step, v)
        implicit none
        type(vector), intent(in) :: v
        real(rk), intent(in) :: k_step

        vpro2%x = v%x * k_step
        vpro2%y = v%y * k_step
        vpro2%z = v%z * k_step
    end function vpro2

    !Define vector division with a scalar
    type(vector) function vdiv(v, k_step)
        implicit none
        type(vector), intent(in) :: v
        real(rk), intent(in) :: k_step

        vdiv = v * (k_step ** (-1))
    end function vdiv

    !Define vector scalar / dot product
    real(rk) function vdot(v1, v2)
        implicit none
        type(vector), intent(in) :: v1, v2

        vdot = (v1%x * v2%x) + (v1%y * v2%y) + (v1%z * v2%z)
    end function vdot

    !Define vector length
    real(rk) function length(v)
        implicit none
        type(vector), intent(in) :: v

        length = (v * v) ** 0.5
    end function length
    
end module types