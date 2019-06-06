Internal compiler error at curry_bug.cs(16,42):: exception caught while emitting MethodBuilder [CurryBug::curry]

Unhandled Exception: System.NullReferenceException: Object reference not set to an instance of an object
  at Mono.CSharp.ConstructedType..ctor (System.Type t, Mono.CSharp.TypeParameter[] type_params, Location l) [0x00000] 
  at Mono.CSharp.TypeContainer.DoResolveType () [0x00000] 
  at Mono.CSharp.TypeContainer.ResolveType () [0x00000] 
  at Mono.CSharp.TypeContainer.ResolveType () [0x00000] 
  at Mono.CSharp.RootScopeInfo.LinkScopes () [0x00000] 
  at Mono.CSharp.ToplevelBlock.CompleteContexts (Mono.CSharp.EmitContext ec) [0x00000] 
  at Mono.CSharp.EmitContext.ResolveTopBlock (Mono.CSharp.EmitContext anonymous_method_host, Mono.CSharp.ToplevelBlock block, Mono.CSharp.Parameters ip, IMethodData md, System.Boolean& unreachable) [0x00000] 
  at Mono.CSharp.EmitContext.EmitTopBlock (IMethodData md, Mono.CSharp.ToplevelBlock block) [0x00000] 
  at Mono.CSharp.MethodData.Emit (Mono.CSharp.DeclSpace parent) [0x00000] 
  at Mono.CSharp.Method.Emit () [0x00000] 
