<Project
 DefaultTargets="Build"
 xmlns="http:schemas.microsoft.com/developer/msbuild/2003">

<!--

 Coveresant.Gui.Console

 Authors:
	Mike Hull (mike.hull@coversant.net)

 (C) 2005 Coversant, Inc (http:www.coversant.net)



 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-->


  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|Linux 1.1.13' ">
		<MonoPath>C:\program files\Mono-1.1.13.2\lib\mono\2.0\</MonoPath>
	</PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|Linux 1.1.13' ">
    <MonoPath>C:\program files\Mono-1.1.13.2\lib\mono\2.0\</MonoPath>
  </PropertyGroup>

  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|Linux' ">
    <MonoPath>C:\program files\Mono-1.1.10\lib\mono\2.0\</MonoPath>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|Linux' ">
    <MonoPath>C:\program files\Mono-1.1.10\lib\mono\2.0\</MonoPath>
  </PropertyGroup>

  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|Mono 2.0' ">
    <MonoPath>C:\program files\Mono-1.1.10\lib\mono\2.0\</MonoPath>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|Mono 2.0' ">
    <MonoPath>C:\program files\Mono-1.1.10\lib\mono\2.0\</MonoPath>
  </PropertyGroup>

  <!--Begin Linux Target-->
	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|Linux' ">
		<DebugSymbols Condition="'$(DebugSymbols)'==''">true</DebugSymbols>
		<DebugType Condition="'$(DebugType)'==''">full</DebugType>
		<Optimize Condition="'$(Optimize)'==''">false</Optimize>
		<OutputPath Condition="'$(OutputPath)'==''">bin\Linux\Debug\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">DEBUG;TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);STANDARD_FRAMEWORK;MONO;LINUX;NET_2_0;MONO_1_1_10</DefineConstants>
		<ErrorReport></ErrorReport>
		<WarningLevel Condition="'$(WarningLevel)'==''">4</WarningLevel>
		<UseHostCompilerIfAvailable>false</UseHostCompilerIfAvailable>
		<NoStdLib>true</NoStdLib>
		<AssemblyKeyContainerName>CoversantStrongName</AssemblyKeyContainerName>
		<AllowUnsafeBlocks>True</AllowUnsafeBlocks>
	</PropertyGroup>

	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|Linux' ">
		<DebugType Condition="'$(DebugType)'==''">pdbonly</DebugType>
		<Optimize Condition="'$(Optimize)'==''">true</Optimize>
		<OutputPath Condition="'$(OutputPath)'==''">bin\Linux\Release\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);STANDARD_FRAMEWORK;MONO;LINUX;NET_2_0;MONO_1_1_10</DefineConstants>
		<ErrorReport></ErrorReport>
		<WarningLevel Condition="'$(WarningLevel)'==''">4</WarningLevel>
		<UseHostCompilerIfAvailable>false</UseHostCompilerIfAvailable>
		<NoStdLib>true</NoStdLib>
		<AssemblyKeyContainerName>CoversantStrongName</AssemblyKeyContainerName>
		<AllowUnsafeBlocks>True</AllowUnsafeBlocks>

	</PropertyGroup>
	<!--End Linux Target-->

  <!--Begin Linux 1.1.13 Target-->
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|Linux 1.1.13' ">
    <DebugSymbols Condition="'$(DebugSymbols)'==''">true</DebugSymbols>
    <DebugType Condition="'$(DebugType)'==''">full</DebugType>
    <Optimize Condition="'$(Optimize)'==''">false</Optimize>
    <OutputPath Condition="'$(OutputPath)'==''">bin\Linux 1.1.13\Debug\</OutputPath>
    <DefineConstants Condition="'$(DefineConstants)'==''">DEBUG;TRACE</DefineConstants>
    <DefineConstants>$(DefineConstants);STANDARD_FRAMEWORK;MONO;LINUX;NET_2_0;MONO_1_1_13</DefineConstants>
    <ErrorReport></ErrorReport>
    <WarningLevel Condition="'$(WarningLevel)'==''">4</WarningLevel>
    <UseHostCompilerIfAvailable>false</UseHostCompilerIfAvailable>
    <NoStdLib>true</NoStdLib>
    <AssemblyKeyContainerName>CoversantStrongName</AssemblyKeyContainerName>
    <AllowUnsafeBlocks>True</AllowUnsafeBlocks>
  </PropertyGroup>

  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|Linux 1.1.13' ">
    <DebugType Condition="'$(DebugType)'==''">pdbonly</DebugType>
    <Optimize Condition="'$(Optimize)'==''">true</Optimize>
    <OutputPath Condition="'$(OutputPath)'==''">bin\Linux 1.1.13\Release\</OutputPath>
    <DefineConstants Condition="'$(DefineConstants)'==''">TRACE</DefineConstants>
    <DefineConstants>$(DefineConstants);STANDARD_FRAMEWORK;MONO;LINUX;NET_2_0;MONO_1_1_13</DefineConstants>
    <ErrorReport></ErrorReport>
    <WarningLevel Condition="'$(WarningLevel)'==''">4</WarningLevel>
    <UseHostCompilerIfAvailable>false</UseHostCompilerIfAvailable>
    <NoStdLib>true</NoStdLib>
    <AssemblyKeyContainerName>CoversantStrongName</AssemblyKeyContainerName>
    <AllowUnsafeBlocks>True</AllowUnsafeBlocks>

  </PropertyGroup>
  <!--End Linux 1.1.13 Target-->


  <!--Begin Mono 2.0 Target-->
	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|Mono 2.0' ">
		<DebugSymbols Condition="'$(DebugSymbols)'==''">true</DebugSymbols>
		<DebugType Condition="'$(DebugType)'==''">full</DebugType>
		<Optimize Condition="'$(Optimize)'==''">false</Optimize>
		<OutputPath Condition="'$(OutputPath)'==''">bin\Mono 2.0\Debug\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">DEBUG;TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);STANDARD_FRAMEWORK;MONO;NET_2_0</DefineConstants>
		<ErrorReport></ErrorReport>
		<WarningLevel Condition="'$(WarningLevel)'==''">4</WarningLevel>
		<UseHostCompilerIfAvailable>false</UseHostCompilerIfAvailable>
		<NoStdLib>true</NoStdLib>
		<AssemblyKeyContainerName>CoversantStrongName</AssemblyKeyContainerName>
		<AllowUnsafeBlocks>True</AllowUnsafeBlocks>

	</PropertyGroup>

	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|Mono 2.0' ">
		<DebugType Condition="'$(DebugType)'==''">pdbonly</DebugType>
		<Optimize Condition="'$(Optimize)'==''">true</Optimize>
		<OutputPath Condition="'$(OutputPath)'==''">bin\Mono 2.0\Release\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">MONO;TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);STANDARD_FRAMEWORK;MONO;NET_2_0</DefineConstants>
		<ErrorReport></ErrorReport>
		<WarningLevel Condition="'$(WarningLevel)'==''">4</WarningLevel>
		<UseHostCompilerIfAvailable>false</UseHostCompilerIfAvailable>
		<NoStdLib>true</NoStdLib>
		<AssemblyKeyContainerName>CoversantStrongName</AssemblyKeyContainerName>
		<AllowUnsafeBlocks>True</AllowUnsafeBlocks>

	</PropertyGroup>

	<!--End Mono 2.0 Target-->
	
	<!-- AnyCPU Target -->
	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' ">
		<DebugSymbols>true</DebugSymbols>
		<DebugType>full</DebugType>
		<Optimize>false</Optimize>
		<OutputPath>bin\Debug\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">DEBUG;TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);STANDARD_FRAMEWORK;NET_2_0;MS_NET_2_0</DefineConstants>
		<ErrorReport>prompt</ErrorReport>
		<WarningLevel>4</WarningLevel>
		<AllowUnsafeBlocks>True</AllowUnsafeBlocks>
	</PropertyGroup>
	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' ">
		<DebugType>pdbonly</DebugType>
		<Optimize>true</Optimize>
		<OutputPath>bin\Release\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);STANDARD_FRAMEWORK;NET_2_0;MS_NET_2_0</DefineConstants>
		<ErrorReport>prompt</ErrorReport>
		<WarningLevel>4</WarningLevel>
		<AllowUnsafeBlocks>True</AllowUnsafeBlocks>
	</PropertyGroup>
	<!--End AnyCPU Target-->

	<!-- Linux and Mono References-->
	<ItemGroup Condition="'$(Configuration)|$(Platform)' == 'Release|Mono 2.0'">
		<Reference Include="mscorlib">
			<Name>mscorlib</Name>
			<HintPath>$(MonoPath)</HintPath>
		</Reference>
	</ItemGroup>

  <ItemGroup Condition="'$(Configuration)|$(Platform)' == 'Release|Linux' ">
    <Reference Include="mscorlib">
      <Name>mscorlib</Name>
      <HintPath>$(MonoPath)</HintPath>
    </Reference>
  </ItemGroup>

  <ItemGroup Condition="'$(Configuration)|$(Platform)' == 'Release|Linux 1.1.13' ">
    <Reference Include="mscorlib">
      <Name>mscorlib</Name>
      <HintPath>$(MonoPath)</HintPath>
    </Reference>
  </ItemGroup>
  
	<!--Import Micrsoft CSharp Targets-->
	<Import Project="$(MSBuildBinPath)\Microsoft.CSharp.targets" />
	
	<!--Override some of the standard target settings-->

	<PropertyGroup>
		<AvailablePlatforms>$(AvailablePlatforms),Linux,Linux 1.1.13,Mono 2.0</AvailablePlatforms>
		<AssemblySearchPaths Condition=" '$(Platform)' == 'Linux' Or '$(Platform)' == 'Mono 2.0' Or '$(Platform)' == 'Linux 1.1.13'">
			{CandidateAssemblyFiles};
			$(ReferencePath);
			{HintPathFromItem};
			{TargetFrameworkDirectory};
			{AssemblyFolders};
			$(OutputPath);
			{GAC}
		</AssemblySearchPaths>
		<TargetFrameworkDirectory Condition=" '$(Platform)' == 'Linux' Or '$(Platform)' == 'Mono 2.0' Or '$(Platform)' == 'Linux 1.1.13'">
			$(MonoPath)
		</TargetFrameworkDirectory>		
	</PropertyGroup>

	<ItemGroup Condition=" '$(Platform)' == 'Linux' Or '$(Platform)' == 'Mono 2.0' Or '$(Platform' == 'Linux 1.1.13'">
		<TargetFrameworkDirectoryItem Include="$(MonoPath)">
			<InProject>false</InProject>
		</TargetFrameworkDirectoryItem>
	</ItemGroup>

  <Target
	   Name="GetFrameworkPaths"
	   DependsOnTargets="$(GetFrameworkPathsDependsOn)">
		<GetFrameworkPath
		  Condition=" '$(Platform)' == 'AnyCPU' Or '$(Platform)' == 'Any CPU'>
			<Output TaskParameter="Path" PropertyName="TargetFrameworkDirectory"/>
			<Output TaskParameter="Path" ItemName="TargetFrameworkDirectoryItem"/>
		</GetFrameworkPath>
		<GetFrameworkSDKPath
			Condition=" '$(Platform)' == 'AnyCPU' Or '$(Platform)' == 'Any CPU'>
			<Output TaskParameter="Path" PropertyName="TargetFrameworkSDKDirectory"/>
			<Output TaskParameter="Path" ItemName="TargetFrameworkSDKDirectoryItem"/>
		</GetFrameworkSDKPath>
	</Target>
</Project>
