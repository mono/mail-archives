using System;
using System.Drawing;
using MonoMac.Foundation;
using MonoMac.AppKit;
using MonoMac.ObjCRuntime;
using MonoMac.CoreGraphics;
using MonoMac.CoreAnimation;
using MonoMac.CoreImage;
using MonoMac.CoreVideo;

namespace MonoMac.QuartzComposer {

	[BaseType (typeof (NSObject))]
	interface QCComposition {
		[Export ("compositionWithFile:")]
		QCComposition GetComposition (string path);

		[Static]
		[Export ("compositionWithData:")]
		QCComposition GetComposition (NSData data);

		[Export ("protocols")]
		NSArray Protocols { get; }

		[Export ("attributes")]
		NSDictionary Attributes { get; }

		[Export ("inputKeys")]
		string[] InputKeys { get; }

		[Export ("outputKeys")]
		string[] OutputKeys { get; }

		[Export ("identifier")]
		string Identifier { get; }
		
		[Field ("QCCompositionAttributeNameKey")]
		NSString AttributeNameKey { get; }

		[Field ("QCCompositionAttributeDescriptionKey")]
		NSString AttributeDescriptionKey { get; }

		[Field ("QCCompositionAttributeCopyrightKey")]
		NSString AttributeCopyrightKey { get; }
		
		[Field ("QCCompositionAttributeBuiltInKey")]
		NSString AttributeBuiltInKey { get; }
		
		[Field ("QCCompositionAttributeIsTimeDependentKey")]
		NSString AttributeIsTimeDependentKey { get; }
		
		[Field ("QCCompositionAttributeHasConsumersKey")]
		NSString AttributeHasConsumersKey { get; }
		
		[Field ("QCCompositionAttributeCategoryKey")]
		NSString AttributeCategoryKey { get; }
		
		[Field ("QCCompositionCategoryDistortion")]
		NSString CategoryDistortion { get; }
				
		[Field ("QCCompositionCategoryStylize")]
		NSString CategoryStylize { get; }
		
		[Field ("QCCompositionCategoryUtility")]
		NSString CategoryUtility { get; }

		[Field ("QCCompositionInputImageKey")]
		NSString InputImageKey { get; }

		[Field ("QCCompositionInputSourceImageKey")]
		NSString InputSourceImageKey { get; }

		[Field ("QCCompositionInputDestinationImageKey")]
		NSString InputDestinationImageKey { get; }

		[Field ("QCCompositionInputRSSFeedURLKey")]
		NSString InputRSSFeedURLKey { get; }

		[Field ("QCCompositionInputRSSArticleDurationKey")]
		NSString InputRSSArticleDurationKey { get; }

		[Field ("QCCompositionInputPreviewModeKey")]
		NSString InputPreviewModeKey { get; }

		[Field ("QCCompositionInputXKey")]
		NSString InputXKey { get; }

		[Field ("QCCompositionInputYKey")]
		NSString InputYKey { get; }

		[Field ("QCCompositionInputScreenImageKey")]
		NSString InputScreenImageKey { get; }

		[Field ("QCCompositionInputAudioPeakKey")]
		NSString InputAudioPeakKey { get; }

		[Field ("QCCompositionInputAudioSpectrumKey")]
		NSString InputAudioSpectrumKey { get; }

		[Field ("QCCompositionInputTrackPositionKey")]
		NSString InputTrackPositionKey { get; }

		[Field ("QCCompositionInputTrackInfoKey")]
		NSString InputTrackInfoKey { get; }

		[Field ("QCCompositionInputTrackSignalKey")]
		NSString InputTrackSignalKey { get; }

		[Field ("QCCompositionInputPrimaryColorKey")]
		NSString InputPrimaryColorKey { get; }

		[Field ("QCCompositionInputSecondaryColorKey")]
		NSString InputSecondaryColorKey { get; }

		[Field ("QCCompositionInputPaceKey")]
		NSString InputPaceKey { get; }

		[Field ("QCCompositionInputMeshKey")]
		NSString InputMeshKey { get; }

		[Field ("QCCompositionOutputImageKey")]
		NSString OutputImageKey { get; }

		[Field ("QCCompositionOutputWebPageURLKey")]
		NSString OutputWebPageURLKey { get; }

		[Field ("QCCompositionOutputMeshKey")]
		NSString OutputMeshKey { get; }

		[Field ("QCCompositionProtocolGraphicAnimation")]
		NSString ProtocolGraphicAnimation { get; }

		[Field ("QCCompositionProtocolGraphicTransition")]
		NSString ProtocolGraphicTransition { get; }

		[Field ("QCCompositionProtocolImageFilter")]
		NSString ProtocolImageFilter { get; }

		[Field ("QCCompositionProtocolScreenSaver")]
		NSString ProtocolScreenSaver { get; }

		[Field ("QCCompositionProtocolRSSVisualizer")]
		NSString ProtocolRSSVisualizer { get; }

		[Field ("QCCompositionProtocolMusicVisualizer")]
		NSString ProtocolMusicVisualizer { get; }

		[Field ("QCCompositionProtocolMeshFilter")]
		NSString ProtocolMeshFilter { get; }

	}


	[BaseType (typeof (CAOpenGLLayer))]
	interface QCCompositionLayer {
		
		[Static]
		[Export ("compositionLayerWithFile:")]
		QCCompositionLayer Create (string path);

		[Static]
		[Export ("compositionLayerWithComposition:")]
		QCCompositionLayer Create (QCComposition composition);

		[Export ("initWithFile:")]
		IntPtr Constructor (string path);

		[Export ("initWithComposition:")]
		IntPtr Constructor (QCComposition composition);

		[Export ("composition")]
		QCComposition Composition { get; }

	}

	[BaseType (typeof (NSObject))]
	interface QCCompositionRepository {
		[Static]
		[Export ("sharedCompositionRepository")]
		QCCompositionRepository SharedCompositionRepository { get; }

		[Export ("compositionWithIdentifier:")]
		QCComposition GetComposition (string identifier);

		[Export ("compositionsWithProtocols:andAttributes:")]
		QCComposition[] GetCompositions (NSArray protocols, NSDictionary attributes);

		[Export ("allCompositions")]
		QCComposition[] AllCompositions { get; }

	}

}