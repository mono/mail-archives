Option Strict On

Public Class Foo

  'Changing Bar to a public class fixes the problem
  Private Class Bar
    Public Function Testing() As Integer
          Return 12 
    End Function
  End Class

  Private b As Bar

  Public Sub New()
    b = New Bar()
  End Sub


  Private Class Baz

     Private parent As Foo

     Public Sub New(ByVal p As Foo)
        parent = p
     End Sub

     Public Function Test(ByVal i As Integer) As Integer
         Return parent.b.Testing() + i
     End Function

  End Class

  Public Function Test(ByVal i As Integer) As Integer
      Dim b As New Baz(Me)
      return b.Test(i)
  End Function
End Class
