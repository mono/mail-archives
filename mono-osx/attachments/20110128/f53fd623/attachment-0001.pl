diff --git a/extras/MonoDevelop.MonoMac/MonoDevelop.MonoMac/MonoDevelop.MonoMac.addin.xml b/extras/MonoDevelop.MonoMac/MonoDevelop.MonoMac/MonoDevelop.MonoMac.addin.xml
index b3bc29c..1790360 100644
--- a/extras/MonoDevelop.MonoMac/MonoDevelop.MonoMac/MonoDevelop.MonoMac.addin.xml
+++ b/extras/MonoDevelop.MonoMac/MonoDevelop.MonoMac/MonoDevelop.MonoMac.addin.xml
@@ -53,6 +53,10 @@
 		            file = "templates/MonoMacEmptyXib.xft.xml"/>
 		<FileTemplate id = "MonoMacApplicationDocumentManifest"
 			    file = "templates/MonoMacApplicationDocumentManifest.xft.xml"/>
+		<FileTemplate id = "MonoMacInheritedNSView"
+		            file = "templates/MonoMacInheritedNSView.xft.xml"/>
+		<FileTemplate id = "MonoMacInheritedNSWindow"
+		            file = "templates/MonoMacInheritedNSWindow.xft.xml"/>
 
 	</Extension>
 
diff --git a/extras/MonoDevelop.MonoMac/MonoDevelop.MonoMac/MonoDevelop.MonoMac.csproj b/extras/MonoDevelop.MonoMac/MonoDevelop.MonoMac/MonoDevelop.MonoMac.csproj
index 0df2bbd..aa288b1 100644
--- a/extras/MonoDevelop.MonoMac/MonoDevelop.MonoMac/MonoDevelop.MonoMac.csproj
+++ b/extras/MonoDevelop.MonoMac/MonoDevelop.MonoMac/MonoDevelop.MonoMac.csproj
@@ -63,11 +63,6 @@
     <Reference Include="glib-sharp, Version=2.12.0.0, Culture=neutral, PublicKeyToken=35e10195dab3c99f">
       <SpecificVersion>False</SpecificVersion>
     </Reference>
-    <Reference Include="MonoDevelop.MacDev, Version=2.4.0.0, Culture=neutral, PublicKeyToken=null">
-      <SpecificVersion>False</SpecificVersion>
-      <HintPath>..\..\MonoDevelop.IPhone\build\MonoDevelop.MacDev.dll</HintPath>
-      <Private>False</Private>
-    </Reference>
     <Reference Include="Mono.Addins, Version=0.4.0.0, Culture=neutral, PublicKeyToken=0738eb9f132ed756">
       <SpecificVersion>False</SpecificVersion>
     </Reference>
@@ -75,6 +70,11 @@
       <SpecificVersion>False</SpecificVersion>
       <HintPath>MonoMac.dll</HintPath>
     </Reference>
+    <Reference Include="MonoDevelop.MacDev, Version=2.6.0.0, Culture=neutral, PublicKeyToken=null">
+      <SpecificVersion>False</SpecificVersion>
+      <HintPath>..\..\MonoDevelop.IPhone\build\MonoDevelop.MacDev.dll</HintPath>
+      <Private>False</Private>
+    </Reference>
   </ItemGroup>
   <ItemGroup>
     <Compile Include="AssemblyInfo.cs" />
@@ -154,10 +154,14 @@
     <None Include="mono-version-check">
       <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
     </None>
+    <None Include="templates\MonoMacInheritedNSView.xft.xml">
+      <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
+    </None>
+    <None Include="templates\MonoMacInheritedNSWindow.xft.xml">
+      <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
+    </None>
   </ItemGroup>
-
   <Import Project="$(MSBuildBinPath)\Microsoft.CSharp.targets" />
-
   <PropertyGroup>
     <MmpSrc>..\..\..\..\artifacts\mmp</MmpSrc>
     <MmpBin>$(OutDir)mmp</MmpBin>
@@ -166,11 +170,10 @@ echo "This build does not include the MonoMac bundler"
 exit 1
 </MmpFakeScript>
   </PropertyGroup>
-
   <Target Name="AfterCompile">
     <Copy SourceFiles="$(MmpSrc)" DestinationFiles="$(MmpBin)" Condition="'$(MmpSrc)' != '' And Exists ('$(MmpSrc)')" />
-    <WriteLinesToFile File="$(MmpBin)" Lines="$(MmpFakeScript)" Condition="!Exists('$(MmpBin)')" /> 
-    <Exec Command="chmod +x '$(MmpBin)'" Condition="'$(MmpSrc)' == '' Or !Exists ('$(MmpSrc)')"  /> 
+    <WriteLinesToFile File="$(MmpBin)" Lines="$(MmpFakeScript)" Condition="!Exists('$(MmpBin)')" />
+    <Exec Command="chmod +x '$(MmpBin)'" Condition="'$(MmpSrc)' == '' Or !Exists ('$(MmpSrc)')" />
     <CreateItem Include="$(MmpBin)">
       <Output TaskParameter="Include" ItemName="FileWrites" />
     </CreateItem>

