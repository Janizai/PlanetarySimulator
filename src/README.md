# Compilation instructions:

Use the following command in the folder src/:

Windows:
gfortran .\constants.f90 .\types.f90 .\simulation.f90 .\units.f90 .\ui.f90 .\files.f90 .\main.f90 -o ..\run\PlanetarySimulator

Linux:
gfortran {constants,types,simulation,units,ui,files,main}.f90 -o ../run/PlanetarySimulator

Or use the following command in the folder run/:

Windows:
gfortran ..\src\constants.f90 ..\src\types.f90 ..\src\simulation.f90 ..\src\units.f90 ..\src\ui.f90 ..\src\files.f90 ..\src\main.f90 -o .\PlanetarySimulator

Linux:
gfortran ../src/{constants,types,simulation,units,ui,files,main}.f90 -o PlanetarySimulator
