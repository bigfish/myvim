#!bin/sh

#build swf and launch with adl
Metrics.swf : Metrics.as Metrics-App.xml	
	amxmlc --library-path+=SWC_FILE Metrics.as
	adl Metrics-App.xml

#package the air app
app: Metrics.swf Metrics-App.xml 
	adt -package -storetype pkcs12 -keystore ${HOME}/flash/cert/cert.p12 -storepass belikemike Metrics.air Metrics-App.xml Metrics.swf assets icons

#package the android app
apk: Metrics.swf Metrics-App.xml 
	adt -package -target apk -storetype pkcs12 -keystore ${HOME}/flash/cert/cert.p12 -storepass belikemike Metrics.apk Metrics-App.xml Metrics.swf assets icons
