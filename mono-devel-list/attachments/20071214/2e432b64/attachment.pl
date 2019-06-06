using System;
using System.Collections.Generic;
using System.Configuration;

class Program
{
    static void Main(string[] args)
    {
        Settings settings = new Settings();

        settings.RandomString = "";

        settings.Save();
    }
}

class Settings : ApplicationSettingsBase
{
    [UserScopedSettingAttribute()]
    [DefaultSettingValueAttribute("Default")]
    public string RandomString
    {
        get { return ((string)(this["RandomString"])); }
        set { this["RandomString"] = value; }
    }

    [UserScopedSettingAttribute()]
    public List<Guid> RandomList
    {
        get { return ((List<Guid>)(this["RandomList"])); }
        set { this["RandomList"] = value; }
    }
}
