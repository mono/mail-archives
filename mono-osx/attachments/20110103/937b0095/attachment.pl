diff --git a/samples/Rulers/RectsView.cs b/samples/Rulers/RectsView.cs
index 83bc812..9949e14 100644
--- a/samples/Rulers/RectsView.cs
+++ b/samples/Rulers/RectsView.cs
@@ -921,7 +921,7 @@ namespace Rulers
 				}
 			}
 				
-			newColor = NSColor.ColorWithDeviceRGBA ((float)rand.NextDouble (),
+			newColor = NSColor.FromDeviceRGBA ((float)rand.NextDouble (),
 			                                        (float)rand.NextDouble (),
 			                                        (float)rand.NextDouble (),
 			                                        1.0f);
diff --git a/samples/Rulers/Rulers.csproj b/samples/Rulers/Rulers.csproj
index 00bd981..2663e1f 100644
--- a/samples/Rulers/Rulers.csproj
+++ b/samples/Rulers/Rulers.csproj
@@ -68,7 +68,7 @@
   </ItemGroup>
   <ItemGroup>
     <None Include="Info.plist" />
-    <None Include="ReadMe\README.rtf" />
+    <None Include="README.md" />
   </ItemGroup>
   <Import Project="$(MSBuildBinPath)\Microsoft.CSharp.targets" />
   <Import Project="$(MSBuildExtensionsPath)\Mono\MonoMac\v0.0\Mono.MonoMac.targets" />
@@ -78,7 +78,4 @@
     <Content Include="EdgeMarkerRight.tiff" />
     <Content Include="EdgeMarkerTop.tiff" />
   </ItemGroup>
-  <ItemGroup>
-    <Folder Include="ReadMe\" />
-  </ItemGroup>
 </Project>
\ No newline at end of file
