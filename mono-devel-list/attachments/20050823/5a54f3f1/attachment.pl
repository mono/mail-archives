<Project
 DefaultTargets="Build"
 xmlns="http://schemas.microsoft.com/developer/msbuild/2003">

	<PropertyGroup>
		<MonoPath>C:\\program files\\Mono-1.1.8\\lib\\mono\\2.0\\</MonoPath>
	</PropertyGroup>

	<!--Begin Linux Target-->
	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|Linux' ">
		<DebugSymbols Condition="'$(DebugSymbols)'==''">true</DebugSymbols>
		<DebugType Condition="'$(DebugType)'==''">full</DebugType>
		<Optimize Condition="'$(Optimize)'==''">false</Optimize>
		<OutputPath Condition="'$(OutputPath)'==''">bin\Linux\Debug\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">DEBUG;TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);MONO;LINUX;</DefineConstants>
		<ErrorReport></ErrorReport>
		<WarningLevel Condition="'$(WarningLevel)'==''">4</WarningLevel>
		<UseHostCompilerIfAvailable>false</UseHostCompilerIfAvailable>
		<NoStdLib>true</NoStdLib>
	</PropertyGroup>

	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|Linux' ">
		<DebugType Condition="'$(DebugType)'==''">pdbonly</DebugType>
		<Optimize Condition="'$(Optimize)'==''">true</Optimize>
		<OutputPath Condition="'$(OutputPath)'==''">bin\Linux\Release\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);MONO;LINUX;</DefineConstants>
		<ErrorReport></ErrorReport>
		<WarningLevel Condition="'$(WarningLevel)'==''">4</WarningLevel>
		<UseHostCompilerIfAvailable>false</UseHostCompilerIfAvailable>
		<NoStdLib>true</NoStdLib>
	</PropertyGroup>
	<!--End Linux Target-->

	<!--Begin Mono 2.0 Target-->
	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|Mono 2.0' ">
		<DebugSymbols Condition="'$(DebugSymbols)'==''">true</DebugSymbols>
		<DebugType Condition="'$(DebugType)'==''">full</DebugType>
		<Optimize Condition="'$(Optimize)'==''">false</Optimize>
		<OutputPath Condition="'$(OutputPath)'==''">bin\Mono 2.0\Debug\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">DEBUG;TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);MONO</DefineConstants>
		<ErrorReport></ErrorReport>
		<WarningLevel Condition="'$(WarningLevel)'==''">4</WarningLevel>
		<UseHostCompilerIfAvailable>false</UseHostCompilerIfAvailable>
		<NoStdLib>true</NoStdLib>
	</PropertyGroup>

	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|Mono 2.0' ">
		<DebugType Condition="'$(DebugType)'==''">pdbonly</DebugType>
		<Optimize Condition="'$(Optimize)'==''">true</Optimize>
		<OutputPath Condition="'$(OutputPath)'==''">bin\Mono 2.0\Release\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">MONO;TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);MONO</DefineConstants>
		<ErrorReport></ErrorReport>
		<WarningLevel Condition="'$(WarningLevel)'==''">4</WarningLevel>
		<UseHostCompilerIfAvailable>false</UseHostCompilerIfAvailable>
		<NoStdLib>true</NoStdLib>
	</PropertyGroup>

	<!--End Mono 2.0 Target-->

	<!--Begin .NET 1.1 Target-->
	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|.NET 1.1' ">
		<DebugSymbols Condition="'$(DebugSymbols)'==''">true</DebugSymbols>
		<DebugType Condition="'$(DebugType)'==''">full</DebugType>
		<Optimize Condition="'$(Optimize)'==''">false</Optimize>
		<OutputPath Condition="'$(OutputPath)'==''">bin\.NET 1.1\Debug\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">DEBUG;TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);NET_1_1</DefineConstants>
		<ErrorReport></ErrorReport>
		<WarningLevel Condition="'$(WarningLevel)'==''">4</WarningLevel>
		<UseHostCompilerIfAvailable>false</UseHostCompilerIfAvailable>
		<CscToolPath>$(SystemRoot)\Microsoft.NET\Framework\v1.1.4322</CscToolPath>
		<TargetFrameworkVersion>v1.0</TargetFrameworkVersion>
	</PropertyGroup>

	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|.NET 1.1' ">
		<DebugType Condition="'$(DebugType)'==''">pdbonly</DebugType>
		<Optimize Condition="'$(Optimize)'==''">true</Optimize>
		<OutputPath Condition="'$(OutputPath)'==''">bin\.NET 1.1\Release\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);NET_1_1</DefineConstants>
		<ErrorReport></ErrorReport>
		<WarningLevel Condition="'$(WarningLevel)'==''">4</WarningLevel>
		<UseHostCompilerIfAvailable>false</UseHostCompilerIfAvailable>
		<CscToolPath>$(SystemRoot)\Microsoft.NET\Framework\v1.1.4322</CscToolPath>
		<TargetFrameworkVersion>v1.0</TargetFrameworkVersion>
	</PropertyGroup>
	<!--End .NET 1.1 Target-->

	<!-- AnyCPU Target -->
	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' ">
		<DebugSymbols>true</DebugSymbols>
		<DebugType>full</DebugType>
		<Optimize>false</Optimize>
		<OutputPath>bin\Debug\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">DEBUG;TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);NET_2_0</DefineConstants>
		<ErrorReport>prompt</ErrorReport>
		<WarningLevel>4</WarningLevel>
	</PropertyGroup>
	<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' ">
		<DebugType>pdbonly</DebugType>
		<Optimize>true</Optimize>
		<OutputPath>bin\Release\</OutputPath>
		<DefineConstants Condition="'$(DefineConstants)'==''">TRACE</DefineConstants>
		<DefineConstants>$(DefineConstants);NET_2_0</DefineConstants>
		<ErrorReport>prompt</ErrorReport>
		<WarningLevel>4</WarningLevel>
	</PropertyGroup>
	<!--End AnyCPU Target-->

	<!-- Linux and Mono References-->
	<ItemGroup Condition="'$(Platform)' == 'Mono 2.0' Or '$(Platform)' == 'Linux' ">
		<Reference Include="mscorlib">
			<Name>mscorlib</Name>
			<HintPath>$(MonoPath)</HintPath>
		</Reference>
	</ItemGroup>

	<!--Import Micrsoft CSharp Targets-->
	<Import Project="$(MSBuildBinPath)\Microsoft.CSharp.targets" />

	<!--Override some of the standard target settings-->

	<PropertyGroup>
		<AvailablePlatforms>$(AvailablePlatforms),Linux,Mono 2.0,.NET 1.1</AvailablePlatforms>
		<AssemblySearchPaths Condition=" '$(Platform)' == 'Linux' Or '$(Platform)' == 'Mono 2.0' Or '$(Platform)' == '.NET 1.1'">
			{CandidateAssemblyFiles};
			$(ReferencePath);
			{HintPathFromItem};
			{TargetFrameworkDirectory};
			{AssemblyFolders};
			$(OutputPath);
			{GAC}
		</AssemblySearchPaths>
		<TargetFrameworkDirectory Condition=" '$(Platform)' == 'Linux' Or '$(Platform)' == 'Mono 2.0'">
			$(MonoPath)
		</TargetFrameworkDirectory>
		<TargetFrameworkDirectory Condition=" '$(Platform)' == '.NET 1.1'">
			$(SystemRoot)\Microsoft.NET\Framework\v1.1.4322
		</TargetFrameworkDirectory>
	</PropertyGroup>

	<ItemGroup Condition=" '$(Platform)' == 'Linux' Or '$(Platform)' == 'Mono 2.0'">
		<TargetFrameworkDirectoryItem Include="$(MonoPath)">
			<InProject>false</InProject>
		</TargetFrameworkDirectoryItem>
	</ItemGroup>
	<ItemGroup Condition=" '$(Platform)' == '.NET 1.1'">
		<TargetFrameworkDirectoryItem Include="$(SystemRoot)\Microsoft.NET\Framework\v1.1.4322">
			<InProject>false</InProject>
		</TargetFrameworkDirectoryItem>
	</ItemGroup>

	<Target
	   Name="GetFrameworkPaths"
	   DependsOnTargets="$(GetFrameworkPathsDependsOn)">
		<GetFrameworkPath
		  Condition=" '$(Platform)' == 'AnyCPU' Or '$(Platform)' == 'Any CPU'">
			<Output TaskParameter="Path" PropertyName="TargetFrameworkDirectory"/>
			<Output TaskParameter="Path" ItemName="TargetFrameworkDirectoryItem"/>
		</GetFrameworkPath>
		<GetFrameworkSDKPath
			Condition=" '$(Platform)' == 'AnyCPU' Or '$(Platform)' == 'Any CPU'">
			<Output TaskParameter="Path" PropertyName="TargetFrameworkSDKDirectory"/>
			<Output TaskParameter="Path" ItemName="TargetFrameworkSDKDirectoryItem"/>
		</GetFrameworkSDKPath>
	</Target>

	<!--Support .NET 1.1 Resrouce Files-->
	<UsingTask TaskName="CFResGen" AssemblyFile="$(MSBuildBinPath)\Microsoft.CompactFramework.Build.Tasks.dll" />
	<PropertyGroup Condition="'$(Platform)' == '.NET 1.1'">
		<ResGenDependsOn>ResolveAssemblyReferences;BeforeResGen;CoreResGen_1_1;AfterResGen</ResGenDependsOn>
	</PropertyGroup>
	<Target
		   Name="CoreResGen_1_1"
		   DependsOnTargets="$(CoreResGenDependsOn)">

		<CFResGen
				  Condition = " '@(ResxWithNoCulture)' != ''"
				  Sources = "@(ResxWithNoCulture)"
				  UseSourcePath = "$(UseSourcePath)"
				  StateFile = "$(IntermediateOutputPath)$(MSBuildProjectFile).CrossCompileResGen.Cache"
				  OutputResources = "@(ManifestResourceWithNoCultureName->'$(IntermediateOutputPath)%(Identity).resources')"
        >
			<Output TaskParameter = "FilesWritten" ItemName="FileWrites"/>
			<Output TaskParameter = "OutputResources" ItemName="ManifestResourceWithNoCulture"/>
		</CFResGen>

		<CFResGen
				  Condition = " '@(ResxWithCulture)' != ''"
				  Sources = "@(ResxWithCulture)"
				  UseSourcePath = "$(UseSourcePath)"
				  StateFile = "$(IntermediateOutputPath)$(MSBuildProjectFile).CrossCompileResGen.Cache"
				  OutputResources = "@(ManifestResourceWithCultureName->'$(IntermediateOutputPath)%(Identity).resources')"
        >
			<!-- Appending to 'FilesWritten' list lets us be part of Clean and Incremental Clean. -->
			<Output TaskParameter = "FilesWritten" ItemName="FileWrites"/>
			<Output TaskParameter = "OutputResources" ItemName="ManifestResourceWithCulture"/>

		</CFResGen>
	</Target>


</Project>