using System;
using System.Runtime.InteropServices;
using Cocoa;

namespace Cocoa
{
    public class UserDefaults : Cocoa.Object
    {
        private static string ObjectiveCName = "NSUserDefaults";
        public UserDefaults(IntPtr native_object) : base(native_object) { }
        public UserDefaults() : base() { }

        //
        // workaround: ideally, this should be a static property - but it needs NativeClass :(.
        //
        public UserDefaults StandardUserDefaults
        {
            get
            {
                return (UserDefaults)(Object.FromIntPtr((IntPtr)ObjCMessaging.objc_msgSend(NativeClass.ToIntPtr(), "standardUserDefaults", typeof(IntPtr)))); 
            }
        }

        public void RegisterDefaults(Dictionary dictionary)
        {
            ObjCMessaging.objc_msgSend(NativeObject, "registerDefaults:", typeof(void),
                typeof(IntPtr), dictionary.NativeObject); // dictionary
        }

        public Object objectForKey(string key)
        {
            return Object.FromIntPtr((IntPtr)ObjCMessaging.objc_msgSend(NativeObject, "objectForKey:", typeof(IntPtr), 
                typeof(IntPtr), new Cocoa.String(key).NativeObject)); // key
        }

        public string StringForKey(string key)
        {
            var obj = objectForKey(key);
            if (obj != null) return obj.ToString();
            return null;
        }

        public void setObjectForKey(Cocoa.Object value, string key)
        {
            ObjCMessaging.objc_msgSend(NativeObject, "setObject:forKey:", typeof(void), 
                typeof(System.IntPtr), value.NativeObject,                  // value
                typeof(System.IntPtr), new Cocoa.String(key).NativeObject); // keys
        }

        public void setObjectForKey(string value, string key)
        {
            if (value != null)
                ObjCMessaging.objc_msgSend(NativeObject, "setObject:forKey:", typeof(void), 
                    typeof(System.IntPtr), new Cocoa.String(value).NativeObject,  // value
                    typeof(System.IntPtr), new Cocoa.String(key).NativeObject);   // key
            else
                ObjCMessaging.objc_msgSend(NativeObject, "setObject:forKey:", typeof(void),
                    typeof(System.IntPtr), 0,  // value
                    typeof(System.IntPtr), new Cocoa.String(key).NativeObject);   // key

        }
    }
}
