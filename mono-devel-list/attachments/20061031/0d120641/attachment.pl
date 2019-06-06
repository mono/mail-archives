Option Strict On

Imports ControlChars = Microsoft.VisualBasic.ControlChars
Imports System
Imports System.Diagnostics
Imports System.IO
Imports System.Runtime.InteropServices
Imports System.ServiceProcess
Imports System.Threading

Namespace ServiceHost
    Friend NotInheritable Class ServiceHost
        Inherits ServiceBase

        Private Shared ArgSeparators As Char()
        Private Shared CmdAutoStart As Boolean
        Private Shared CmdPriority As ProcessPriorityClass
        Private Shared CmdFileName As String
        Private Shared CmdArguments As String
        Private AutoStart As Boolean
        Private Priority As ProcessPriorityClass
        Private FileName As String
        Private Arguments As String
        Private WorkingDirectory As String
        Private Process As Process

        Shared Sub New()
            ArgSeparators = New Char() {" "c, ControlChars.Tab}
        End Sub

        Private Sub New()
            MyBase.New()

            Me.ServiceName = "ServiceHost"
            Me.CanStop = True
            Me.EventLog.Source = "Service Host"
            Me.AutoLog = False
        End Sub

        <MTAThread()> _
        Public Shared Sub Main()
            Dim Index As Integer
            Dim CommandLine As String
            Dim ArgName As String

            CmdPriority = ProcessPriorityClass.Normal
            CommandLine = Environment.CommandLine
            If CommandLine.Chars(0) = """"c Then
                Index = CommandLine.IndexOf(""""c, 1)
            Else
                Index = CommandLine.IndexOfAny(ArgSeparators)
            End If
            If Index > 0 AndAlso Index + 1 < CommandLine.Length Then
                CommandLine = CommandLine.Substring(Index + 1).TrimStart(ArgSeparators)

                Do While CommandLine.StartsWith("-")
                    Index = CommandLine.IndexOfAny(ArgSeparators, 1)
                    If Index >= 0 Then
                        ArgName = CommandLine.Substring(0, Index).ToLower
                    Else
                        ArgName = String.Empty
                    End If
                    If Index + 1 >= CommandLine.Length Then
                        CommandLine = String.Empty
                    Else
                        CommandLine = CommandLine.Substring(Index + 1).TrimStart(ArgSeparators)
                    End If
                    If ArgName.Equals("-autostart") Then
                        CmdAutoStart = True
                    ElseIf ArgName.Equals("-highpriority") Then
                        CmdPriority = ProcessPriorityClass.High
                    ElseIf ArgName.Equals("-lowpriority") Then
                        CmdPriority = ProcessPriorityClass.Idle
                    End If
                Loop

                If CType(CommandLine.Length, Boolean) Then
                    If CommandLine.Chars(0) = """"c Then
                        Index = CommandLine.IndexOf(""""c, 1)
                    Else
                        Index = CommandLine.IndexOfAny(ArgSeparators)
                        If Index = -1 Then
                            CmdFileName = CommandLine
                        End If
                    End If
                    If Index > 0 Then
                        If Index + 1 < CommandLine.Length Then
                            CmdFileName = CommandLine.Substring(0, Index)
                            CmdArguments = CommandLine.Substring(Index + 1).TrimStart(ArgSeparators)
                            If Not CType(CmdArguments.Length, Boolean) Then CmdArguments = Nothing
                        Else
                            CmdFileName = CommandLine.TrimEnd(ArgSeparators)
                        End If
                    End If
                    If Not CmdFileName Is Nothing AndAlso Not CType(CmdFileName.Length, Boolean) Then CmdFileName = Nothing
                End If
            End If
            ServiceBase.Run(New ServiceHost())
        End Sub

        Protected Overrides Sub OnStart(ByVal args() As String)
            Dim BeginIndex As Integer
            Dim Index As Integer
            Dim ArgumentArray As String()

            If CType(args.Length, Boolean) Then
                Priority = ProcessPriorityClass.Normal
                Do While BeginIndex < args.Length AndAlso args(BeginIndex).StartsWith("-")
                    args(BeginIndex) = args(BeginIndex).ToLower
                    If args(BeginIndex).Equals("-autostart") Then
                        AutoStart = True
                    ElseIf args(BeginIndex).Equals("-highpriority") Then
                        Priority = ProcessPriorityClass.High
                    ElseIf args(BeginIndex).Equals("-lowpriority") Then
                        Priority = ProcessPriorityClass.Idle
                    Else
                        Me.EventLog.WriteEntry("Invalid argument: " & args(BeginIndex), EventLogEntryType.Warning)
                    End If
                    BeginIndex += 1
                Loop
            Else
                AutoStart = CmdAutoStart
                Priority = CmdPriority
            End If
            If BeginIndex >= args.Length Then
                If CmdFileName Is Nothing Then
                    Me.EventLog.WriteEntry("No executable was specified.", EventLogEntryType.Error)
                    GoTo NoStart
                Else
                    FileName = CmdFileName
                    Arguments = CmdArguments
                End If
            Else
                FileName = args(BeginIndex)
                If args.Length > 1 Then
                    ReDim ArgumentArray(args.Length - BeginIndex - 2)
                    Array.Copy(args, BeginIndex + 1, ArgumentArray, 0, ArgumentArray.Length)

                    For Index = 0 To ArgumentArray.Length - 1
                        If ArgumentArray(Index).IndexOfAny(ArgSeparators) >= 0 Then
                            ArgumentArray(Index) = """" & ArgumentArray(Index) & """"
                        End If
                    Next
                    Arguments = String.Join(" ", ArgumentArray)
                End If
            End If
            Try
                WorkingDirectory = Path.GetDirectoryName(FileName)
            Catch
            End Try
            If WorkingDirectory Is Nothing Then WorkingDirectory = String.Empty
            If AutoStart Then StartProcess()
NoStart:
            Me.EventLog.WriteEntry("Service started successfully.", EventLogEntryType.Information)
        End Sub

        Protected Overrides Sub OnStop()
            If Not Process Is Nothing Then StopProcess()
            AutoStart = False
            FileName = Nothing
            Arguments = Nothing
            WorkingDirectory = Nothing
            Me.EventLog.WriteEntry("Service stopped successfully.", EventLogEntryType.Information)
        End Sub

        Protected Overrides Sub OnCustomCommand(ByVal command As Integer)
            Select Case command
                Case &H80
                    StartProcess()
                Case &H81
                    StopProcess()
                Case &H82
                    If Not Process Is Nothing Then StopProcess()
                    StartProcess()
                Case Else
                    Me.EventLog.WriteEntry("Invalid command: " & command.ToString, EventLogEntryType.Warning)
            End Select
        End Sub

        Private Sub StartProcess()
            Dim StartInfo As ProcessStartInfo

            Try
                If FileName Is Nothing Then
                    Me.EventLog.WriteEntry("No executable was specified.", EventLogEntryType.Error)
                ElseIf Not Me.Process Is Nothing AndAlso Me.Process.HasExited Then
                    Me.Process.Dispose()
                    Me.Process = Nothing
                End If
                If Not Me.Process Is Nothing Then
                    Me.EventLog.WriteEntry(Me.FileName & " is already running.", EventLogEntryType.Warning)
                Else
                    StartInfo = New ProcessStartInfo(Me.FileName, Me.Arguments)
                    StartInfo.UseShellExecute = False
                    StartInfo.WorkingDirectory = Me.WorkingDirectory

                    Me.Process = Process.Start(StartInfo)
                    Me.Process.PriorityClass = Me.Priority
                    AddHandler Process.Exited, AddressOf OnProcessExited
                    Me.Process.EnableRaisingEvents = True

                    Me.EventLog.WriteEntry(Me.FileName & " started successfully.", EventLogEntryType.Information)
                End If
            Catch Ex As Exception
                Me.EventLog.WriteEntry(Me.FileName & " cannot be started: " & Ex.Message, EventLogEntryType.Error)
            End Try
        End Sub

        Private Sub StopProcess()
            Try
                If Me.Process Is Nothing Then
                    Me.EventLog.WriteEntry(Me.FileName & " is already stopped.", EventLogEntryType.Warning)
                ElseIf Me.Process.HasExited Then
                    Me.Process.Dispose()
                    Me.Process = Nothing
                Else
                    RemoveHandler Process.Exited, AddressOf OnProcessExited
                    Try
                        Me.Process.Kill()
                    Catch E As Exception
                        AddHandler Process.Exited, AddressOf OnProcessExited
                        Throw E
                    End Try
                    Me.Process.Dispose()
                    Me.Process = Nothing
                    Me.EventLog.WriteEntry(Me.FileName & " stopped successfully.", EventLogEntryType.Information)
                End If
            Catch Ex As Exception
                Me.EventLog.WriteEntry(Me.FileName & " cannot be stopped: " & Ex.Message, EventLogEntryType.Error)
            End Try
        End Sub

        Private Sub OnProcessExited(ByVal sender As Object, ByVal e As EventArgs)
            If Not CType(DirectCast(sender, Process).ExitCode, Boolean) Then
                Me.EventLog.WriteEntry(Me.FileName & " exited successfully.", EventLogEntryType.Information)
            Else
                Me.EventLog.WriteEntry(Me.FileName & " exited. Exit code: 0x" & DirectCast(sender, Process).ExitCode.ToString("x8"), EventLogEntryType.Warning)
            End If
            Me.Process.Dispose()
            Me.Process = Nothing
        End Sub
    End Class
End Namespace