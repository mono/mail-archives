diff --git a/data/net_4_0/web.config b/data/net_4_0/web.config
index db1c2b8..2a7dfd2 100644
--- a/data/net_4_0/web.config
+++ b/data/net_4_0/web.config
@@ -76,6 +76,7 @@
 		  <!--
 		  <add path="*.svc" verb="*" type="System.ServiceModel.Activation.HttpHandler, System.ServiceModel.Activation, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" validate="False"/>
 		  -->
+                  <add verb="*" path="*.svc" type="System.ServiceModel.Channels.SvcHttpHandlerFactory, System.ServiceModel, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" />
 		  <add path="*.rules" verb="*" type="System.Web.HttpForbiddenHandler" validate="True"/>
 		  <!--
 		  <add path="*.xoml" verb="*" type="System.ServiceModel.Activation.HttpHandler, System.ServiceModel.Activation, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" validate="False"/>
