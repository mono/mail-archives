<Project DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <Configuration Condition=" '$(Configuration)' == '' ">Debug</Configuration>
    <Platform Condition=" '$(Platform)' == '' ">AnyCPU</Platform>
    <ProductVersion>8.0.50727</ProductVersion>
    <SchemaVersion>2.0</SchemaVersion>
    <ProjectGuid>{6C8F8EFF-B272-4876-98EC-FCD48A75E1DE}</ProjectGuid>
    <OutputType>Exe</OutputType>
    <AppDesignerFolder>Properties</AppDesignerFolder>
    <RootNamespace>DVBRecorder</RootNamespace>
    <AssemblyName>DVBRecorder</AssemblyName>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' ">
    <DebugSymbols>true</DebugSymbols>
    <DebugType>full</DebugType>
    <Optimize>false</Optimize>
    <OutputPath>bin\Debug\</OutputPath>
    <DefineConstants>DEBUG;TRACE</DefineConstants>
    <ErrorReport>prompt</ErrorReport>
    <WarningLevel>4</WarningLevel>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' ">
    <DebugType>pdbonly</DebugType>
    <Optimize>true</Optimize>
    <OutputPath>..\..\..\..\..\</OutputPath>
    <DefineConstants>TRACE</DefineConstants>
    <ErrorReport>prompt</ErrorReport>
    <WarningLevel>4</WarningLevel>
  </PropertyGroup>
  <ItemGroup>
    <Reference Include="Linux-DVB, Version=0.4.10030.1230, Culture=neutral, processorArchitecture=MSIL">
      <SpecificVersion>False</SpecificVersion>
      <HintPath>T:\linuxdvb-sharp-0-0.4\LinuxDVB\Linux-DVB.dll</HintPath>
    </Reference>
    <Reference Include="MySql.Data, Version=1.0.8.0, Culture=neutral, PublicKeyToken=c5687fc88969c44d, processorArchitecture=MSIL">
      <SpecificVersion>False</SpecificVersion>
      <HintPath>..\MySql.Data.dll</HintPath>
    </Reference>
    <Reference Include="System" />
    <Reference Include="System.Data" />
    <Reference Include="System.Xml" />
  </ItemGroup>
  <ItemGroup>
    <Compile Include="Base\clsConsole.cs" />
    <Compile Include="Collections\clsDVBDevices.cs" />
    <Compile Include="Base\clsLogger.cs" />
    <Compile Include="Base\clsMain.cs" />
    <Compile Include="Base\clsAppConfig.cs" />
    <Compile Include="Collections\clsRecording.cs" />
    <Compile Include="DVB\clsChannelDB.cs" />
    <Compile Include="DVB\clsChannelDecoder.cs" />
    <Compile Include="DVB\clsLinuxTV.cs" />
    <Compile Include="Properties\AssemblyInfo.cs" />
    <Compile Include="DVB\clsTSReader.cs" />
    <Compile Include="Utils\clsDatabase.cs" />
    <Compile Include="Utils\clsMaintenance.cs" />
    <Compile Include="Utils\clsTelnetServer.cs" />
  </ItemGroup>
  <ItemGroup>
    <Content Include="TextFile1.txt" />
  </ItemGroup>
  <ItemGroup>
    <None Include="ClassDiagram1.cd" />
  </ItemGroup>
  <Import Project="$(MSBuildBinPath)\Microsoft.CSharp.targets" />
  <!-- To modify your build process, add your task inside one of the targets below and uncomment it. 
       Other similar extension points exist, see Microsoft.Common.targets.
  <Target Name="BeforeBuild">
  </Target>
  <Target Name="AfterBuild">
  </Target>
  -->
</Project>