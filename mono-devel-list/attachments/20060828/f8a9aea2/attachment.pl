Option Strict On

Public Class novbruntimeref
        Public Shared Function AscW(ByVal x As Char, ByVal y as String) As Integer
            Return AscW(x, "x"c)
        End Function

        Public Shared Function Asc1(ByVal x As Char) As Integer
            Return AscW(x, x)
        End Function
End Class

Class novbruntimeref1
        Public Shared Function Ascw(ByVal x As Char, ByVal y as Char) As Integer
            Return Ascw(x, y)
        End Function

        Public Shared Function Asc1(ByVal x As Char) As Integer
            Return Ascw(x, x)
        End Function
End Class

Class novbruntimeref2
        Public Shared Function Asc1(ByVal x As Char) As Integer
            Return novbruntimeref.AscW(x, x)
        End Function
End Class
