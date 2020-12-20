!Simulates Newtonian motion in gravity fields
module simulation
    use constants, only : Gc, c
    use types
    implicit none
    
    contains

    !The Newtonian force of gravity applied on object_1 exerted by object_2
    type(vector) function Fg(object_1, object_2)
        implicit none
        type(object), intent(in) :: object_1, object_2
        
        type(vector) :: vect
        real(rk) :: dist

        vect = object_1%pos - object_2%pos
        dist = length(vect)

        if (dist == 0) then
            print '(2(a, i0))', 'Zero division error caused by object_', &
            object_1%num, ' and object_', object_2%num
            stop
        end if

        Fg = (-1) * Gc * (object_1%mass * object_2%mass) / (dist ** 3) * vect
    end function Fg

    !The force of gravity from the Schwarzschild metric
    type(vector) function Fe(object_1, object_2)
        implicit none
        type(object), intent(in) :: object_1, object_2
        
        type(vector) :: vect
        real(rk) :: dist, rs

        vect = object_1%pos - object_2%pos
        dist = length(vect)
        rs = 2 * Gc * object_2%mass / c ** 2

        if (dist == 0) then
            print '(2(a, i0))', 'Zero division error caused by object_', &
            object_1%num, ' and object_', object_2%num
            stop
        end if

        Fe = (1 - rs/dist) ** (-0.5) * (-1) * Gc * (object_1%mass * object_2%mass) / (dist ** 3) * vect
    end function Fe
    
    !Calculates the acceleration the object has
    type(vector) function acceleration(N, q, objects)
        implicit none       
        type(object), intent(in) :: objects(N)
        integer, intent(in) :: N, q
        
        type(vector) :: force
        integer :: i

        force = vector(0, 0, 0)

        do i = 1, N
            if (i /= q) then
                force = force + Fg(objects(q), objects(i))
            end if
        end do

        acceleration = force / objects(q)%mass
    end function acceleration

    !Simulates motion using the Velocity Verlet algorithm
    subroutine simulator(N, objects, dt)
        implicit none
        type(object), intent(inout) :: objects(N)
        real(rk), intent(in) :: dt
        integer, intent(in) :: N
        
        type(vector) :: r, v, a
        integer :: i

        do i = 1, N
            r = objects(i)%pos + objects(i)%vel * dt + real(0.5, rk) * objects(i)%acc * (dt ** 2)
            a = acceleration(N, i, objects)
            v = objects(i)%vel + real(0.5, rk) * (objects(i)%acc + a) * dt
            objects(i)%pos = r
            objects(i)%vel = v
            objects(i)%acc = a
        end do
    end subroutine simulator
end module simulation