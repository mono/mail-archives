Index: Novell.Directory.Ldap/Connection.cs
===================================================================
--- Novell.Directory.Ldap/Connection.cs	(revision 56783)
+++ Novell.Directory.Ldap/Connection.cs	(working copy)
@@ -505,6 +505,16 @@
 							// Keep trying for the lock
 							continue;
 						}
+						catch (System.Threading.ThreadAbortException ex)
+						{
+							if (ex.ExceptionState == SupportClass.ThreadClass.INTERRUPT)
+							{
+								// Keep trying for the lock
+								Thread.ResetAbort();
+								continue;
+							}
+							else throw ex;
+						}
 					}
 				}
 				writeSemaphoreCount++;
@@ -606,6 +616,15 @@
 				{
 					;
 				}
+				catch (System.Threading.ThreadAbortException ex)
+				{
+					if (ex.ExceptionState == SupportClass.ThreadClass.INTERRUPT)
+					{
+						Thread.ResetAbort();
+					}
+					else throw ex;
+				}
+
 				if(reader!=null)
 				{
 					rInst=reader;
@@ -1506,6 +1525,7 @@
 				{
 					// Abort has been called on reader
 					// before closing sockets, from shutdown
+					Thread.ResetAbort();
 					return;
 				}
 #if TARGET_JVM
Index: Novell.Directory.Ldap/SupportClass.cs
===================================================================
--- Novell.Directory.Ldap/SupportClass.cs	(revision 56783)
+++ Novell.Directory.Ldap/SupportClass.cs	(working copy)
@@ -634,9 +634,10 @@
 			/// <summary>
 			/// Interrupts a thread that is in the WaitSleepJoin thread state
 			/// </summary>
+			public const string INTERRUPT = "interrupt";
 			public virtual void Interrupt()
 			{
-				threadField.Interrupt();
+				threadField.Abort(INTERRUPT);
 			}
 	      
 			/// <summary>
Index: Novell.Directory.Ldap/Message.cs
===================================================================
--- Novell.Directory.Ldap/Message.cs	(revision 56783)
+++ Novell.Directory.Ldap/Message.cs	(working copy)
@@ -166,6 +166,15 @@
 						{
 							; // do nothing
 						}
+					catch (System.Threading.ThreadAbortException ex)
+					{
+						if (ex.ExceptionState == SupportClass.ThreadClass.INTERRUPT)
+						{
+							System.Threading.Thread.ResetAbort();
+						}
+						else throw ex;
+					}
+
 						if (waitForReply_Renamed_Field)
 						{
 							continue;
@@ -599,6 +608,15 @@
 				{
 					// the timer was stopped, do nothing
 				}
+				catch (System.Threading.ThreadAbortException ex)
+				{
+					if (ex.ExceptionState == SupportClass.ThreadClass.INTERRUPT)
+					{
+						System.Threading.Thread.ResetAbort();
+					}
+					else throw ex;
+				}
+
 				return ;
 			}
 		}
Index: Novell.Directory.Ldap/MessageAgent.cs
===================================================================
--- Novell.Directory.Ldap/MessageAgent.cs	(revision 56783)
+++ Novell.Directory.Ldap/MessageAgent.cs	(working copy)
@@ -418,6 +418,15 @@
 						catch (System.Threading.ThreadInterruptedException ex)
 						{
 						}
+						catch (System.Threading.ThreadAbortException ex)
+						{
+							if (ex.ExceptionState == SupportClass.ThreadClass.INTERRUPT)
+							{
+								System.Threading.Thread.ResetAbort();
+							}
+							else throw ex;
+						}
+
 					} /* end while */
 				} /* end synchronized */
 			}
Index: Novell.Directory.Ldap.Events/LdapEventSource.cs
===================================================================
--- Novell.Directory.Ldap.Events/LdapEventSource.cs	(revision 56783)
+++ Novell.Directory.Ldap.Events/LdapEventSource.cs	(working copy)
@@ -329,6 +329,16 @@
 	      {
 		Console.WriteLine("EventsGenerator::Run Got ThreadInterruptedException e = {0}", e);
 	      }
+				catch (System.Threading.ThreadAbortException ex)
+				{
+					if (ex.ExceptionState == SupportClass.ThreadClass.INTERRUPT)
+					{
+						Console.WriteLine("EventsGenerator::Run Got ThreadInterruptedException e = {0}", e);
+						Thread.ResetAbort();
+					}
+					else throw ex;
+				}
+
 	    }
 	    
 	    if (isrunning) 
