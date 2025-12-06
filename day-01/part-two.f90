program main
  implicit none
  integer, parameter :: MAX_SIZE = 10000
  integer :: direction(MAX_SIZE) = 0
  integer :: magnitude(MAX_SIZE) = 0
  ! number_of_lines = 1 and not 0 since I effectively want to pre-fill with 0
  integer :: number_of_lines = 1
  integer :: iostat
  character :: direction_character

  integer :: differences(MAX_SIZE)
  integer :: running_total(MAX_SIZE)
  integer :: location(MAX_SIZE)
  integer :: i
  integer :: rotations(MAX_SIZE)
  integer :: clockwise_rotations(MAX_SIZE), anticlockwise_rotations(MAX_SIZE)

  read(*, "(A)", iostat=iostat, advance='no') direction_character
  do while (iostat == 0)
    number_of_lines = number_of_lines + 1
    ! Using -1 because I use cshift and the last element becomes junk
    if (number_of_lines > MAX_SIZE - 1) then
      print *, "Too many lines in input"
      exit
    end if
    read(*, *, iostat=iostat) magnitude(number_of_lines)
    direction(number_of_lines) = merge(-1, 1, direction_character == 'L')
    read(*, "(A)", iostat=iostat, advance='no') direction_character
  end do
  
  differences = direction * magnitude
  running_total = 50 + [(sum(differences(1:i)), i = 1, number_of_lines)]
  location = modulo(running_total, 100)
  clockwise_rotations = (location + cshift(magnitude, 1)) / 100
  anticlockwise_rotations = (modulo(100 - location, 100) + cshift(magnitude, 1)) / 100
  rotations = merge(clockwise_rotations, anticlockwise_rotations, cshift(direction, 1) == 1)
  rotations = merge(0, rotations, location == 0 .and. cshift(magnitude, 1) < 100)
  print *, sum(rotations(1:number_of_lines - 1))
end program
