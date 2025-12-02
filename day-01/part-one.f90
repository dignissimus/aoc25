program main
  implicit none
  integer, parameter :: MAX_SIZE = 10000
  integer :: direction(MAX_SIZE) = 0
  integer :: magnitude(MAX_SIZE) = 0
  integer :: number_of_lines = 0
  integer :: iostat
  character :: direction_character

  integer :: differences(MAX_SIZE)
  integer :: running_total(MAX_SIZE)
  integer :: location(MAX_SIZE)
  integer :: i


  read(*, "(A)", iostat=iostat, advance='no') direction_character
  do while (iostat == 0)
    number_of_lines = number_of_lines + 1
    if (number_of_lines > MAX_SIZE) then
      print *, "Too many lines in input"
      exit
    end if
    read(*, *, iostat=iostat) magnitude(number_of_lines)
    direction(number_of_lines) = merge(-1, 1, direction_character == 'L')
    read(*, "(A)", iostat=iostat, advance='no') direction_character
  end do
  
  differences = direction(1:number_of_lines) * magnitude(1:number_of_lines)
  running_total = 50 + [(sum(differences(1:i)), i = 1, number_of_lines)]
  location = mod(running_total, 100)
  print *, location(1)
  print *, count(location(1:number_of_lines) == 0)
end program 
