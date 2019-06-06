System.Web.UI.TemplateControl explicitly names the methods that should be mapped to events during WireupAutomaticEvents.

                static string [] methodNames = { "Page_Init",
                                                 "Page_Load",
                                                 "Page_DataBind",
                                                 "Page_PreRender",
                                                 "Page_Dispose",
                                                 "Page_Error" };

"Page_Dispose" that is listed should be "Page_Disposed" since System.Web.UI.Control exposes its private DisposedEvent via as:
	public event EventHandler Disposed

Similarly,
System.Web.UI.Control's UnloadEvent is accessed via:
	public event EventHandler Unload
But there is no "Page_Unload" in methodNames.

And,
System.Web.UI.TemplateControl's abortTransaction and commitTransaction are accessed via:
	public event EventHandler AbortTransaction
	public event EventHandler CommitTransaction
But there is no "Page_AbortTransaction" or "Page_CommitTransaction" in methodNames.

Although I haven't tested it yet, I believe the fix should only entail correcting the typo, and adding the three extra events to System.Web.UI.TemplateControl's methodNames declaration.

static string [] methodNames = { "Page_Init",
                                 "Page_Load",
                                 "Page_DataBind",
                                 "Page_PreRender",
                                 "Page_Disposed",
                                 "Page_Error",
                                 "Page_Unload",
                                 "Page_AbortTransaction",
                                 "Page_CommitTransaction" }; 

I found this while testing "dbpage1.aspx", I needed to close my DB Connection, and found that both Page_Unload & Page_Disposed wouldn't work. Adding "this.Unload += new System.EventHandler(this.Page_Unload);" within an init section would fix the problem.

This is my first post to mono-devel-list, if I'm off topic, or out of line, please let me know.

Regards,
Ivan Hamilton

