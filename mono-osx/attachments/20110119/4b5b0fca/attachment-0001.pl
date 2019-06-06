>From 281a7607ca54af172bb8f4065468525c1dcbc499 Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Wed, 19 Jan 2011 17:07:20 +0200
Subject: [PATCH] C#-fied NSPasteboard interfaces.

---
 src/appkit.cs |  100 +++++++++++++++++++++++++++++++++------------------------
 1 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/src/appkit.cs b/src/appkit.cs
index 59a1330..96ab4e8 100644
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -6725,7 +6725,7 @@ namespace MonoMac.AppKit {
 		bool WriteObjects (NSPasteboardReading [] objects);
 
 		[Export ("readObjectsForClasses:options:")]
-		NSObject [] ReadObjectsForClassesoptions (NSPasteboardReading [] classArray, NSDictionary options);
+		NSObject [] ReadObjectsForClasses (NSPasteboardReading [] classArray, NSDictionary options);
 
 		[Export ("pasteboardItems")]
 		NSPasteboardItem [] PasteboardItems { get; }
@@ -6749,95 +6749,111 @@ namespace MonoMac.AppKit {
 		string [] Types { get; }
 
 		[Export ("availableTypeFromArray:")]
-		string AvailableTypeFromArray (string [] types);
+		string GetAvailableTypeFromArray (string [] types);
 
 		[Export ("setData:forType:")]
-		bool SetDataforType (NSData data, string dataType);
+		bool SetDataForType (NSData data, string dataType);
 
 		[Export ("setPropertyList:forType:")]
-		bool SetPropertyListforType (NSObject plist, string dataType);
+		bool SetPropertyListForType (NSObject plist, string dataType);
 
 		[Export ("setString:forType:")]
-		bool SetStringforType (string str, string dataType);
+		bool SetStringForType (string str, string dataType);
 
 		[Export ("dataForType:")]
-		NSData DataForType (string dataType);
+		NSData GetDataForType (string dataType);
 
 		[Export ("propertyListForType:")]
-		NSObject PropertyListForType (string dataType);
+		NSObject GetPropertyListForType (string dataType);
 
 		[Export ("stringForType:")]
-		string StringForType (string dataType);
-        
+		string GetStringForType (string dataType);
+
+		// Pasteboard data types
+
 		[Field ("NSStringPboardType")]
-		NSString NSStringPboardType { get; }
+		NSString NSStringType{ get; }
 		
 		[Field ("NSFilenamesPboardType")]
-		NSString NSFilenamesPboardType{ get; }
+		NSString NSFilenamesType{ get; }
 		
 		[Field ("NSPostScriptPboardType")]
-		NSString NSPostScriptPboardType{ get; }
+		NSString NSPostScriptType{ get; }
         
 		[Field ("NSTIFFPboardType")]
-		NSString NSTiffPboardType{ get; }
+		NSString NSTiffType{ get; }
 		
 		[Field ("NSRTFPboardType")]
-		NSString NSRtfPboardType{ get; }
+		NSString NSRtfType{ get; }
 		
 		[Field ("NSTabularTextPboardType")]
-		NSString NSTabularTextPboardType{ get; }
+		NSString NSTabularTextType{ get; }
 		
 		[Field ("NSFontPboardType")]
-		NSString NSFontPboardType{ get; }
+		NSString NSFontType{ get; }
 		
 		[Field ("NSRulerPboardType")]
-		NSString NSRulerPboardType{ get; }
+		NSString NSRulerType{ get; }
 		
 		[Field ("NSFileContentsPboardType")]
-		NSString NSFileContentsPboardType{ get; }
+		NSString NSFileContentsType{ get; }
 		
 		[Field ("NSColorPboardType")]
-		NSString NSColorPboardType{ get; }
+		NSString NSColorType{ get; }
 		
 		[Field ("NSRTFDPboardType")]
-		NSString NSRtfdPboardType{ get; }
+		NSString NSRtfdType{ get; }
 		
 		[Field ("NSHTMLPboardType")]
-		NSString NSHtmlPboardType{ get; }
+		NSString NSHtmlType{ get; }
 		
 		[Field ("NSPICTPboardType")]
-		NSString NSPictPboardType{ get; }
+		NSString NSPictType{ get; }
 		
 		[Field ("NSURLPboardType")]
-		NSString NSUrlPboardType{ get; }
+		NSString NSUrlType{ get; }
 		
 		[Field ("NSPDFPboardType")]
-		NSString NSPdfPboardType{ get; }
+		NSString NSPdfType{ get; }
 		
 		[Field ("NSVCardPboardType")]
-		NSString NSVCardPboardType{ get; }
+		NSString NSVCardType{ get; }
 		
 		[Field ("NSFilesPromisePboardType")]
-		NSString NSFilesPromisePboardType{ get; }
+		NSString NSFilesPromiseType{ get; }
 		
 		[Field ("NSMultipleTextSelectionPboardType")]
-		NSString NSMultipleTextSelectionPboardType{ get; }
+		NSString NSMultipleTextSelectionType{ get; }
+
+		// Pasteboard names: for NSPasteboard.FromName()
+
+		[Field ("NSGeneralPboard")]
+		NSString NSGeneralPasteboardName { get; }
+
+		[Field ("NSFontPboard")]
+		NSString NSFontPasteboardName { get; }
+
+		[Field ("NSRulerPboard")]
+		NSString NSRulerPasteboardName { get; }
+
+		[Field ("NSFindPboard")]
+		NSString NSFindPasteboardName { get; }
 
 		[Field ("NSDragPboard")]
-		NSString NSDragPboard { get; }
+		NSString NSDragPasteboardName { get; }
 	}
 	
 	[BaseType (typeof (NSObject))]
 	[Model]
 	public interface NSPasteboardWriting {
 		[Export ("writableTypesForPasteboard:")]
-		string [] WritableTypesForPasteboard (NSPasteboard pasteboard);
+		string [] GetWritableTypesForPasteboard (NSPasteboard pasteboard);
 
 		[Export ("writingOptionsForType:pasteboard:")]
-		NSPasteboardWritingOptions WritingOptions (string type, NSPasteboard pasteboard);
+		NSPasteboardWritingOptions GetWritingOptionsForType (string type, NSPasteboard pasteboard);
 
 		[Export ("pasteboardPropertyListForType:")]
-		NSObject PasteboardPropertyListForType (string type);
+		NSObject GetPasteboardPropertyListForType (string type);
 	}
 
 	[BaseType (typeof (NSObject))]
@@ -6846,28 +6862,28 @@ namespace MonoMac.AppKit {
 		string [] Types { get; }
 
 		[Export ("availableTypeFromArray:")]
-		string AvailableTypeFromArray (string [] types);
+		string GetAvailableTypeFromArray (string [] types);
 
 		[Export ("setDataProvider:forTypes:")]
-		bool SetDataProviderforTypes (NSPasteboardItemDataProvider dataProvider, string [] types);
+		bool SetDataProviderForTypes (NSPasteboardItemDataProvider dataProvider, string [] types);
 
 		[Export ("setData:forType:")]
-		bool SetDataforType (NSData data, string type);
+		bool SetDataForType (NSData data, string type);
 
 		[Export ("setString:forType:")]
-		bool SetStringforType (string str, string type);
+		bool SetStringForType (string str, string type);
 
 		[Export ("setPropertyList:forType:")]
-		bool SetPropertyListforType (NSObject propertyList, string type);
+		bool SetPropertyListForType (NSObject propertyList, string type);
 
 		[Export ("dataForType:")]
-		NSData DataForType (string type);
+		NSData GetDataForType (string type);
 
 		[Export ("stringForType:")]
-		string StringForType (string type);
+		string GetStringForType (string type);
 
 		[Export ("propertyListForType:")]
-		NSObject PropertyListForType (string type);
+		NSObject GetPropertyListForType (string type);
 	}
 
 	[BaseType (typeof (NSObject))]
@@ -6887,15 +6903,15 @@ namespace MonoMac.AppKit {
 	public interface NSPasteboardReading {
 		[Abstract]
 		[Export ("readableTypesForPasteboard:")]
-		string [] ReadableTypesForPasteboard (NSPasteboard pasteboard);
+		string [] GetReadableTypesForPasteboard (NSPasteboard pasteboard);
 
 		[Abstract]
 		[Export ("readingOptionsForType:pasteboard:")]
-		NSPasteboardReadingOptions ReadingOptionsForTypepasteboard (string type, NSPasteboard pasteboard);
+		NSPasteboardReadingOptions GetReadingOptionsForType (string type, NSPasteboard pasteboard);
 
 		[Abstract]
 		[Export ("initWithPasteboardPropertyList:ofType:")]
-		NSObject InitWithPasteboardPropertyListofType (NSObject propertyList, string type);
+		NSObject InitWithPasteboardPropertyList (NSObject propertyList, string type);
 	}
 	
 	[BaseType (typeof (NSActionCell), Events=new Type [] { typeof (NSPathCellDelegate) }, Delegates=new string [] { "WeakDelegate" })]
-- 
1.7.2

