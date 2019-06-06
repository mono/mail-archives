using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using Mono.Unix;

namespace Coversant.Linux.Proc
{
    public class UnixProcStatusList : List<UnixProcStatus>
    {
        public const string PROC_DIR = "/proc";

        public UnixProcStatus FindParentOf(UnixProcStatus child)
        {
            return base.Find(new Predicate<UnixProcStatus>(child.IsChildOf));
        }
        public UnixProcStatus[] FindChildrenOf(UnixProcStatus parent)
        {
            return base.FindAll(new Predicate<UnixProcStatus>(parent.IsParentOf)).ToArray();
        }
        public UnixProcStatus[] FindByNameExcludingThisProcess(string Name)
        {
            List<UnixProcStatus> list = new List<UnixProcStatus>();
            foreach (UnixProcStatus status in FindByName(Name))
            {
                list.Add(status);
            }
            List<UnixProcStatus> ignore = new List<UnixProcStatus>();
            List<UnixProcStatus> retval = new List<UnixProcStatus>();
            UnixProcStatus current = UnixProcStatus.GetCurrentProcStatus();
            foreach (UnixProcStatus status in current.GetGroup(this))
            {
                ignore.Add(status);
            }
            foreach (UnixProcStatus proc in list)
            {
                bool ignoreit = false;
                foreach (UnixProcStatus ig in ignore)
                {
                    if (proc.Pid == ig.Pid)
                    {
                        ignoreit = true;
                        break;
                    }
                }
                if (!ignoreit) retval.Add(proc);
            }
            return retval.ToArray();
        }
        public UnixProcStatus[] FindByName(string Name)
        {
            if (Name == null) throw new ArgumentNullException("Cannot find by null name.");
            List<UnixProcStatus> list = new List<UnixProcStatus>();
            Name = Name.Trim();
            foreach (UnixProcStatus proc_status in this)
            {
                if (Name.Equals(proc_status.Name))
                {
                    list.Add(proc_status);
                }
            }
            return list.ToArray();
        }
        public UnixProcStatus[] FindParentsInGroup(UnixProcStatus[] group)
        {
            if (group.Length == 0) throw new ArgumentException("group cannot be empty");
            if (group.Length == 1) return group;
            Dictionary<string, UnixProcStatus> parents = new Dictionary<string, UnixProcStatus>();
            foreach (UnixProcStatus proc in group)
            {
                string ppid = proc.PPid;
                if (!parents.ContainsKey(ppid))
                    parents.Add(ppid, proc);
            }
            foreach (UnixProcStatus proc in group)
            {
                if (parents.ContainsKey(proc.Pid))
                {
                    parents.Remove(proc.Pid);
                }
            }
            int count =parents.Values.Count;
            UnixProcStatus[] retval = new UnixProcStatus[count];
            if (count > 0)
                parents.Values.CopyTo(retval, 0);
            return retval;
        }
        private UnixProcStatusList() 
        {}

        #region Static Methods
        public static UnixProcStatusList GetProcessList()
        {
            List<string> pids = new List<string>();
            UnixProcStatusList procs = new UnixProcStatusList();
            for (int i = 1; i < 10; i++)
            {
                foreach (string pid_dir in Directory.GetDirectories(PROC_DIR, string.Format("{0}*", i)))
                {
                    pids.Add(pid_dir);
                }
            }
            foreach (string pid in pids)
            {
                string status = Path.Combine(pid,"status");
                try
                {
                    UnixProcStatus proc_status = new UnixProcStatus(status);
                    procs.Add(proc_status);
                }
                catch
                { }
            }
            return procs;
        }
        #endregion
    }
}
