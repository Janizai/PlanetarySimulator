!Stores constant values througout the program
module constants
    implicit none

    !Reals and Strings
    integer, parameter :: rk = selected_real_kind(10, 20), maxlen = 256
    
    !Default units
    real(rk), parameter :: s = 1, m = 1, kg = 1

    !Constants
    real(rk), parameter :: Gc = 6.67408e-11, c = 299792458

    !Time
    real(rk), parameter :: min = 60 * s, h = 60 * min, d = 24 * h, w = 7 * d, y = 365.25 * d
    
    !Distance
    real(rk), parameter :: km = 1e+3, Mm = 1e+6,  AU = 1.495978707e+11, pc = 3.08567758e+16, ly = 9.4605284e+15
    
    !Masses
    real(rk), parameter :: M_Sun = 1.989e+30
    real(rk), parameter :: M_Mer = 3.285e+23, M_Ven = 4.867e+24, M_Ear = 5.972e+24, M_Mar = 6.39e+23
    real(rk), parameter :: M_Jup = 1.898e+27, M_Sat = 5.683e+26, M_Ura = 8.681e+25, M_Nep = 1.024e+26

    !Store unit strings
    character(5), parameter :: units_time(6) = ['s    ','min  ','h    ','d    ','w    ','y    ']
    character(5), parameter :: units_dist(6) = ['m    ', 'km   ', 'Mm   ', 'AU   ', 'pc   ', 'ly   ']
    character(5), parameter :: units_mass(10) = ['kg   ', 'M_Sun', 'M_Mer', 'M_Ven', 'M_Ear', 'M_Mar', &
                                                    'M_Jup', 'M_Sat', 'M_Ura', 'M_Nep']
    !Store unit values
    real(rk), parameter :: values_time(6) = [s, min, h, d, w, y]
    real(rk), parameter :: values_dist(6) = [m, km, Mm, AU, pc, ly]
    real(rk), parameter :: values_mass(10) = [kg, M_Sun, M_Mer, M_Ven, M_Ear, M_Mar, M_Jup, M_Sat, M_Ura, M_Nep]
end module constants