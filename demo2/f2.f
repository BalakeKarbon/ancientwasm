      INTEGER FUNCTION ff(m)
      CHARACTER*26 m
      WRITE(*,*)'Hello from Fortran'
      m = 'Return string from Fortran'
      ff = 20
      RETURN
      END
