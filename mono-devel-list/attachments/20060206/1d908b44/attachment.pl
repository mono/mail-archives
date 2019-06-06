using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using Mono.Unix;

namespace Coversant.Linux.Proc
{
    public class UnixProcStatus
    {

        #region Private Members
        private string _Name;
        private string _State;
        private string _SleepAVG;
        private string _Tgid;
        private string _Pid;
        private string _PPid;
        private string _TracerPid;
        private string _Uid;
        private string _Gid;
        private string _FDSize;
        private string _Groups;
        private string _Threads;
        private string _SigQ;
        private string _SigPnd;
        private string _ShdPnd;
        private string _SigBlk;
        private string _SigIgn;
        private string _SigCgt;
        private string _CapInh;
        private string _CapPrm;
        private string _CapEff;
        #endregion

        #region Public Properties
        public string Name{ get { return _Name == null ? string.Empty : _Name; } }
        public string State { get { return _State == null ? string.Empty : _State; } }
        public string SleepAVG { get { return _SleepAVG == null ? string.Empty : _SleepAVG; } }
        public string Tgid { get { return _Tgid == null ? string.Empty : _Tgid; } }
        public string Pid { get { return _Pid == null ? string.Empty : _Pid; } }
        public string PPid { get { return _PPid == null ? string.Empty : _PPid; } }
        public string TracerPid { get { return _TracerPid == null ? string.Empty : _TracerPid; } }
        public string Uid { get { return _Uid == null ? string.Empty : _Uid; } }
        public string Gid { get { return _Gid == null ? string.Empty : _Gid; } }
        public string FDSize { get { return _FDSize == null ? string.Empty : _FDSize; } }
        public string Groups { get { return _Groups == null ? string.Empty : _Groups; } }
        public string Threads { get { return _Threads == null ? string.Empty : _Threads; } }
        public string SigQ { get { return _SigQ == null ? string.Empty : _SigQ; } }
        public string SigPnd { get { return _SigPnd == null ? string.Empty : _SigPnd; } }
        public string ShdPnd { get { return _ShdPnd == null ? string.Empty : _ShdPnd; } }
        public string SigBlk { get { return _SigBlk == null ? string.Empty : _SigBlk; } }
        public string SigIgn { get { return _SigIgn == null ? string.Empty : _SigIgn; } }
        public string SigCgt { get { return _SigCgt == null ? string.Empty : _SigCgt; } }
        public string CapInh { get { return _CapInh == null ? string.Empty : _CapInh; } }
        public string CapPrm { get { return _CapPrm == null ? string.Empty : _CapPrm; } }
        public string CapEff { get { return _CapEff == null ? string.Empty : _CapEff; } }

        public UnixProcStatus Parent
        {
            get
            {
                UnixProcStatusList list = UnixProcStatusList.GetProcessList();
                return list.FindParentOf(this);
            }
        }
        public UnixProcStatus[] Children
        {
            get
            {
                UnixProcStatusList list = UnixProcStatusList.GetProcessList();
                return list.FindChildrenOf(this);
            }
        }
        public UnixProcStatus[] AllChildren
        {
            get
            {
                UnixProcStatusList list = UnixProcStatusList.GetProcessList();
                return RecurseChildren(list);
            }
        }
        #endregion

        #region Predicates
        public bool IsChildOf(UnixProcStatus parent)
        {
            return parent != null && parent.Pid != null && 
                this.PPid != null && this.PPid.Length > 0 &&
                parent.Pid == this.PPid;
        }
        public bool IsParentOf(UnixProcStatus child)
        {
            return child != null && child.PPid != null && this.Pid != null && this.Pid.Length > 0 &&
                child.PPid == this.Pid;
        }
        public bool IsCurrentProcess()
        {
            int pid = Mono.Unix.UnixProcess.GetCurrentProcessId();
            try
            {
                return this.Pid != null && pid == int.Parse(this.Pid);
            }
            catch
            {
                return false;
            }
        }
        public static bool IsCurrentProcess(UnixProcStatus proc)
        {
            return proc.IsCurrentProcess();
        }
        #endregion

        #region Constructor
        internal UnixProcStatus(string status_file)
        {
            if (File.Exists(status_file))
            {
                FileStream stream = new FileStream(status_file, FileMode.Open, FileAccess.Read);
                StreamReader sr = new StreamReader(stream);
                try
                {
                    while (sr.Peek() > 0)
                        ParseLine(sr.ReadLine());
                }
                finally
                {
                    sr.Close();
                }
            }
        }
        #endregion

        #region Public Static Methods
        public static UnixProcStatus GetCurrentProcStatus()
        {
            UnixProcStatusList list;
            list = UnixProcStatusList.GetProcessList();
            return GetCurrentProcStatus(list);
        }
        public static UnixProcStatus GetCurrentProcStatus(UnixProcStatusList list)
        {
            int pid = Mono.Unix.UnixProcess.GetCurrentProcessId();
            UnixProcStatus current = list.Find(new Predicate<UnixProcStatus>(UnixProcStatus.IsCurrentProcess));
            return current;
        }
        public static UnixProcStatus GetThisProcessesParent()
        {
            UnixProcStatusList list;
            list = UnixProcStatusList.GetProcessList();
            UnixProcStatus c = GetCurrentProcStatus(list);
            return c.GetParent(list);
        }
        public UnixProcStatus[] GetGroup()
        {
            return GetGroup(UnixProcStatusList.GetProcessList());
        }
        public UnixProcStatus[] GetGroup(UnixProcStatusList list)
        {
            List<UnixProcStatus> procs = new List<UnixProcStatus>();
            if (_Name != null)
            {
                UnixProcStatus parent = GetParent(list);
                foreach (UnixProcStatus proc in parent.RecurseChildren(list))
                {
                    if (proc.Name == _Name)
                    {
                        procs.Add(proc);
                    }
                }
            }
            return procs.ToArray();
        }

        public UnixProcStatus GetParent(UnixProcStatusList list)
        {
            UnixProcStatus parent = this;
            while (true)
            {
                UnixProcStatus check_parent = list.FindParentOf(parent);
                if (check_parent != null && check_parent.Name != null && check_parent.Name == _Name)
                    parent = check_parent;
                else
                    break;
            }
            return parent;
        }

        internal UnixProcStatus[] RecurseChildren(UnixProcStatusList list)
        {
            List<UnixProcStatus> procs = new List<UnixProcStatus>();
            procs.Add(this);
            foreach (UnixProcStatus item in list.FindChildrenOf(this))
            {
                foreach (UnixProcStatus status in item.RecurseChildren(list))
                {
                    procs.Add(status);
                }
            }
            return procs.ToArray();
        }
        #endregion

        #region Private Methods
        private bool ParseLine(string line)
        {
            if (line == null) return false;
            int colon = line.IndexOf(':');

            if (colon > 0 && line.Length > colon)
            {
                switch(line.Substring(0,colon).ToLower())
                {
                    case "name":
                        _Name = line.Substring(colon + 1).Trim();
                        break;
                    case "state":
                        _State = line.Substring(colon + 1).Trim();
                        break;
                    case "sleepavg":
                        _SleepAVG = line.Substring(colon + 1).Trim();
                        break;
                    case "tgid":
                        _Tgid = line.Substring(colon + 1).Trim();
                        break;
                    case "pid":
                        _Pid = line.Substring(colon + 1).Trim();
                        break;
                    case "ppid":
                        _PPid = line.Substring(colon + 1).Trim();
                        break;
                    case "tracerpid":
                        _TracerPid = line.Substring(colon + 1).Trim();
                        break;
                    case "uid":
                        _Uid = line.Substring(colon + 1).Trim();
                        break;
                    case "gid":
                        _Gid  = line.Substring(colon + 1).Trim();
                        break;
                    case "fdsize":
                        _FDSize = line.Substring(colon + 1).Trim();
                        break;
                    case "groups":
                        _Groups = line.Substring(colon + 1).Trim();
                        break;
                    case "threads":
                        _Threads = line.Substring(colon + 1).Trim();
                        break;
                    case "sigq":
                        _SigQ = line.Substring(colon + 1).Trim();
                        break;
                    case "sigpnd":
                        _SigPnd = line.Substring(colon + 1).Trim();
                        break;
                    case "sigblk":
                        _SigBlk = line.Substring(colon + 1).Trim();
                        break;
                    case "sigign":
                        _SigIgn = line.Substring(colon + 1).Trim();
                        break;
                    case "sigcgt":
                        _SigCgt = line.Substring(colon + 1).Trim();
                        break;
                    case "capinh":
                        _CapInh = line.Substring(colon + 1).Trim();
                        break;
                    case "capprm":
                        _CapPrm = line.Substring(colon + 1).Trim();
                        break;
                    case "capeff":
                        _CapEff = line.Substring(colon + 1).Trim();
                        break;
                }
            }
            return true;
        }
        #endregion

        public override string ToString()
        {
            return string.Format("UnixProcStatus ({0}: {1})", this.Pid, this.Name);
        }
    }
}
