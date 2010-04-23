
" Vim syntax file
" Language:     haxe

" Please check :help haxe.vim for comments on some of the options available.

"set errorformat=%f\:%l\:\ characters\ %c-%*[^\ ]\ %m,%f\:%l\:\ %m
set errorformat=%f\:%l\:\ characters\ %c-%*[^\ ]\ %m,%f\:%l\:\ %m

" Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  " we define it here so that included files can test for it
  let main_syntax='haxe'
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ HaxeHiLink hi link <args>
else
  command! -nargs=+ HaxeHiLink hi def link <args>
endif

" some characters that cannot be in a haxe program (outside a string)
syn match haxeError "[\\@`]"
syn match haxeError "<<<\|=>\|<>\|||=\|&&=\|\*\/"

" use separate name so that it can be deleted in haxecc.vim
syn match   haxeError2 "#\|=<"
HaxeHiLink haxeError2 haxeError


" keyword definitions
syn keyword haxeExternal    import extern package
syn keyword haxeConditional if else switch
syn keyword haxeRepeat      while for do in
syn keyword haxeBoolean     true false
syn keyword haxeConstant    null
syn keyword haxeTypedef     this super
syn keyword haxeOperator    new cast 
syn keyword haxeType        Void Bool Int Float Dynamic
syn keyword haxeStatement   return
syn keyword haxeStorageClass    var final typedef enum
syn keyword haxeFunction    function
" syn keyword haxeStatic        
syn keyword haxeExceptions      throw try catch finally untyped
syn keyword haxeAssert      assert
syn keyword haxeMethodDecl      synchronized throws
syn keyword haxeClassDecl       extends implements interface
syn match   haxeOperator "\.\.\."
" to differentiate the keyword class from MyClass.class we use a match here
syn match   haxeTypedef     "\.\s*\<class\>"ms=s+1
syn match   haxeClassDecl       "^class\>"
syn match   haxeClassDecl       "[^.]\s*\<class\>"ms=s+1
syn keyword haxeBranch      break continue nextgroup=haxeUserLabelRef skipwhite
syn match   haxeUserLabelRef    "\k\+" contained
syn keyword haxeScopeDecl       static public protected private abstract override 

" haxe.lang.*
syn match haxeLangClass "\<System\>"
syn keyword haxeLangClass  Array BasicType Class Date DateTools EReg Hash IntHash IntIter Iterator Lambda List Math Md5 Reflect Std String StringBuf StringTools Xml XmlType
HaxeHiLink haxeLangObject            haxeConstant
syn cluster haxeTop add=haxeLangObject,haxeLangClass
syn cluster haxeClasses add=haxeLangClass

if filereadable(expand("<sfile>:p:h")."/haxeid.vim")
  source <sfile>:p:h/haxeid.vim
endif

if exists("haxe_space_errors")
  if !exists("haxe_no_trail_space_error")
    syn match   haxeSpaceError  "\s\+$"
  endif
  if !exists("haxe_no_tab_space_error")
    syn match   haxeSpaceError  " \+\t"me=e-1
  endif
endif

syn region  haxeLabelRegion     transparent matchgroup=haxeLabel start="\<case\>" matchgroup=NONE end=":" contains=haxeNumber,haxeCharacter
syn match   haxeUserLabel       "^\s*[_$a-zA-Z][_$a-zA-Z0-9_]*\s*:"he=e-1 contains=haxeLabel
syn keyword haxeLabel       default

" The following cluster contains all haxe groups except the contained ones
syn cluster haxeTop add=haxeExternal,haxeError,haxeError,haxeBranch,haxeLabelRegion,haxeLabel,haxeConditional,haxeRepeat,haxeBoolean,haxeConstant,haxeTypedef,haxeOperator,haxeType,haxeType,haxeStatement,haxeStorageClass,haxeAssert,haxeExceptions,haxeMethodDecl,haxeClassDecl,haxeClassDecl,haxeClassDecl,haxeScopeDecl,haxeError,haxeError2,haxeUserLabel,haxeLangObject


" Comments
syn keyword haxeTodo         contained TODO FIXME XXX
if exists("haxe_comment_strings")
  syn region  haxeCommentString    contained start=+"+ end=+"+ end=+$+ end=+\*/+me=s-1,he=s-1 contains=haxeSpecial,haxeCommentStar,haxeSpecialChar,@Spell
  syn region  haxeComment2String   contained start=+"+  end=+$\|"+  contains=haxeSpecial,haxeSpecialChar,@Spell
  syn match   haxeCommentCharacter contained "'\\[^']\{1,6\}'" contains=haxeSpecialChar
  syn match   haxeCommentCharacter contained "'\\''" contains=haxeSpecialChar
  syn match   haxeCommentCharacter contained "'[^\\]'"
  syn cluster haxeCommentSpecial add=haxeCommentString,haxeCommentCharacter,haxeNumber
  syn cluster haxeCommentSpecial2 add=haxeComment2String,haxeCommentCharacter,haxeNumber
endif
syn region  haxeComment      start="/\*"  end="\*/" contains=@haxeCommentSpecial,haxeTodo,@Spell
syn match   haxeCommentStar      contained "^\s*\*[^/]"me=e-1
syn match   haxeCommentStar      contained "^\s*\*$"
syn match   haxeLineComment      "//.*" contains=@haxeCommentSpecial2,haxeTodo,@Spell
HaxeHiLink haxeCommentString haxeString
HaxeHiLink haxeComment2String haxeString
HaxeHiLink haxeCommentCharacter haxeCharacter

syn cluster haxeTop add=haxeComment,haxeLineComment

if exists("haxe_haxedoc") || main_syntax == 'jsp'
  syntax case ignore
  " syntax coloring for haxedoc comments (HTML)
  " syntax include @haxeHtml <sfile>:p:h/html.vim
  " unlet b:current_syntax
  syn region  haxeDocComment    start="/\*\*"  end="\*/" keepend contains=haxeCommentTitle,@haxeHtml,haxeDocTags,haxeTodo,@Spell
  syn region  haxeCommentTitle  contained matchgroup=haxeDocComment start="/\*\*"   matchgroup=haxeCommentTitle keepend end="\.$" end="\.[ \t\r<&]"me=e-1 end="[^{]@"me=s-2,he=s-1 end="\*/"me=s-1,he=s-1 contains=@haxeHtml,haxeCommentStar,haxeTodo,@Spell,haxeDocTags

  syn region haxeDocTags  contained start="{@\(link\|linkplain\|inherit[Dd]oc\|doc[rR]oot\|value\)" end="}"
  syn match  haxeDocTags  contained "@\(see\|param\|exception\|throws\|since\)\s\+\S\+" contains=haxeDocParam
  syn match  haxeDocParam contained "\s\S\+"
  syn match  haxeDocTags  contained "@\(version\|author\|return\|deprecated\|serial\|serialField\|serialData\)\>"
  syntax case match
endif

" match the special comment /**/
syn match   haxeComment      "/\*\*/"

" Strings and constants
syn match   haxeSpecialError     contained "\\."
syn match   haxeSpecialCharError contained "[^']"
syn match   haxeSpecialChar      contained "\\\([4-9]\d\|[0-3]\d\d\|[\"\\'ntbrf]\|u\x\{4\}\)"
syn match haxeEregEscape    contained "\(\\\\\|\\/\)"
syn region  haxeEreg        start=+\~\/+ end=+\/[gims]*+ contains=haxeEregEscape

syn region  haxeString      start=+"+ end=+"+ contains=haxeSpecialChar,haxeSpecialError,@Spell
syn region  haxeSingleString  start=+'+ end=+'+ 
" next line disabled, it can cause a crash for a long line
"syn match   haxeStringError      +"\([^"\\]\|\\.\)*$+
syn match   haxeCharacter    "'[^']*'" contains=haxeSpecialChar,haxeSpecialCharError
syn match   haxeCharacter    "'\\''" contains=haxeSpecialChar
syn match   haxeCharacter    "'[^\\]'"
syn match   haxeNumber       "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
"syn match   haxeNumber      "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match   haxeNumber       "\(\<\d\+\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match   haxeNumber       "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match   haxeNumber       "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"


syn region haxeCondIf start="#if \+!\?" end="\W" skip="([A-Za-z0-9_ |&!]\+)"
syn region haxeCondElse start="#else \+!\?" end="\W" skip="([A-Za-z0-9_ |&!]\+)"
syn match haxeCondEnd "#end"
syn match haxeCondError "#else *$"

" unicode characters
syn match   haxeSpecial "\\u\d\{4\}"

syn cluster haxeTop add=haxeString,haxeCharacter,haxeNumber,haxeSpecial,haxeStringError

if exists("haxe_highlight_functions")
  if haxe_highlight_functions == "indent"
    syn match  haxeFuncDef "^\(\t\| \{8\}\)[_$a-zA-Z][_$a-zA-Z0-9_. \[\]]*([^-+*/()]*)" contains=haxeType,haxeStorageClass,@haxeClasses
    syn region haxeFuncDef start=+^\(\t\| \{8\}\)[$_a-zA-Z][$_a-zA-Z0-9_. \[\]]*([^-+*/()]*,\s*+ end=+)+ contains=haxeType,haxeStorageClass,@haxeClasses
    syn match  haxeFuncDef "^  [$_a-zA-Z][$_a-zA-Z0-9_. \[\]]*([^-+*/()]*)" contains=haxeType,haxeStorageClass,@haxeClasses
    syn region haxeFuncDef start=+^  [$_a-zA-Z][$_a-zA-Z0-9_. \[\]]*([^-+*/()]*,\s*+ end=+)+ contains=haxeType,haxeStorageClass,@haxeClasses
  else
    " This line catches method declarations at any indentation>0, but it assumes
    " two things:
    "   1. class names are always capitalized (ie: Button)
    "   2. method names are never capitalized (except constructors, of course)
    syn region haxeFuncDef start=+\s\+\(\(void\|boolean\|char\|byte\|short\|int\|long\|float\|double\|\([A-Za-z_][A-Za-z0-9_$]*\.\)*[A-Z][A-Za-z0-9_$]*\)\(\[\]\)*\s\+[a-z][A-Za-z0-9_$]*\|[A-Z][A-Za-z0-9_$]*\)\s*(+ end=+)+ contains=haxeType,haxeStorageClass,haxeComment,haxeLineComment,@haxeClasses
  endif
  syn match  haxeBraces  "[{}]"
  syn cluster haxeTop add=haxeFuncDef,haxeBraces
endif

if exists("haxe_mark_braces_in_parens_as_errors")
  syn match haxeInParen      contained "[{}]"
  HaxeHiLink haxeInParen    haxeError
  syn cluster haxeTop add=haxeInParen
endif

" catch errors caused by wrong parenthesis
syn region  haxeParenT  transparent matchgroup=haxeParen  start="("  end=")" contains=@haxeTop,haxeParenT1
syn region  haxeParenT1 transparent matchgroup=haxeParen1 start="(" end=")" contains=@haxeTop,haxeParenT2 contained
syn region  haxeParenT2 transparent matchgroup=haxeParen2 start="(" end=")" contains=@haxeTop,haxeParenT  contained
syn match   haxeParenError       ")"
HaxeHiLink haxeParenError       haxeError

if !exists("haxe_minlines")
  let haxe_minlines = 10
endif
exec "syn sync ccomment haxeComment minlines=" . haxe_minlines
"copied actionscript syntax here
syn case ignore
syn match   actionScriptLineComment			"\/\/.*$"
syn match   actionScriptCommentSkip			"^[ \t]*\*\($\|[ \t]\+\)"
syn region  actionScriptCommentString			start=+"+  skip=+\\\\\|\\"+  end=+"+ end=+\*/+me=s-1,he=s-1 contains=actionScriptSpecial,actionScriptCommentSkip,@htmlPreproc
syn region  actionScriptComment2String			start=+"+  skip=+\\\\\|\\"+  end=+$\|"+  contains=actionScriptSpecial,@htmlPreproc
syn region  actionScriptComment				start="/\*"  end="\*/" contains=actionScriptCommentString,actionScriptCharacter,actionScriptNumber
syn match   actionScriptSpecial				"\\\d\d\d\|\\."
syn region  actionScriptStringD				start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=actionScriptSpecial,@htmlPreproc
syn region  actionScriptStringS				start=+'+  skip=+\\\\\|\\'+  end=+'+  contains=actionScriptSpecial,@htmlPreproc
syn match   actionScriptSpecialCharacter		"'\\.'"
syn match   actionScriptNumber				"-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn keyword actionScriptConditional			if else and or not
syn keyword actionScriptRepeat				do while for in
syn keyword actionScriptCase				break continue switch case default
syn keyword actionScriptConstructor			new
syn keyword actionScriptObjects				arguments Array Boolean Date _global Math Number Object String super var this Accessibility Color Key _level Mouse _root Selection Sound Stage System TextFormat LoadVars XML XMLSocket XMLNode LoadVars Button TextField TextSnapshot CustomActions Error ContextMenu ContextMenuItem NetConnection NetStream Video PrintJob MovieClipLoader StyleSheet Camera LocalConnection Microphone SharedObject MovieClip
syn keyword actionScriptStatement			return with
syn keyword actionScriptFunction			function on onClipEvent
syn keyword actionScriptValue				true false undefined null NaN void
syn keyword actionScriptArray				concat join length pop push reverse shift slice sort sortOn splice toString unshift
syn keyword actionScriptDate				getDate getDay getFullYear getHours getMilliseconds getMinutes getMonth getSeconds getTime getTimezoneOffset getUTCDate getUTCDay getUTCFullYear getUTCHours getUTCMilliseconds getUTCMinutes getUTCMonth getUTCSeconds getYear setDate setFullYear setHours setMilliseconds setMinutes setMonth setSeconds setTime setUTCDate setUTCFullYear setUTCHours setUTCMilliseconds setUTCMinutes setUTCMonth setUTCSeconds setYear UTC 
syn keyword actionScriptMath				abs acos asin atan atan2 ceil cos E exp floor log LOG2E LOG10E LN2 LN10 max min PI pow random round sin sqrt SQRT1_2 SQRT2 tan -Infinity Infinity
syn keyword actionScriptNumberObj			MAX_VALUE MIN_VALUE NaN NEGATIVE_INFINITY POSITIVE_INFINITY valueOf 
syn keyword actionScriptObject				addProperty __proto__ registerClass toString unwatch valueOf watch
syn keyword actionScriptString				charAt charCodeAt concat fromCharCode indexOf lastIndexOf length slice split substr substring toLowerCase toUpperCase add le lt gt ge eq ne chr mbchr mblength mbord mbsubstring ord
syn keyword actionScriptColor				getRGB getTransform setRGB setTransform
syn keyword actionScriptKey					addListener BACKSPACE CAPSLOCK CONTROL DELETEKEY DOWN END ENTER ESCAPE getAscii getCode HOME INSERT isDown isToggled LEFT onKeyDown onKeyUp PGDN PGUP removeListener RIGHT SHIFT SPACE TAB UP ALT
syn keyword actionScriptMouse				hide onMouseDown onMouseUp onMouseMove show onMouseWheel
syn keyword actionScriptSelection			getBeginIndex getCaretIndex getEndIndex getFocus setFocus setSelection	
syn keyword actionScriptSound				attachSound duration getBytesLoaded getBytesTotal getPan getTransform getVolume loadSound onLoad onSoundComplete position setPan setTransform setVolume start stop onID3
syn keyword actionScriptStage				align height onResize scaleMode width
syn keyword actionScriptSystem				capabilities hasAudioEncoder hasAccessibility hasAudio hasMP3 language manufacturer os pixelAspectRatio screenColor screenDPI screenResolution.x screenResolution.y version hasVideoEncoder security useCodepage exactSettings hasEmbeddedVideo screenResolutionX screenResolutionY input isDebugger serverString hasPrinting playertype hasStreamingAudio hasScreenBroadcast hasScreenPlayback hasStreamingVideo avHardwareDisable localFileReadDisable windowlesDisable active update description forceSimple noAutoLabeling shortcut silent
syn keyword actionScriptTextFormat			align blockIndent bold bullet color font getTextExtent indent italic leading leftMargin rightMargin size tabStops target underline url	
syn keyword actionScriptCommunication		contentType getBytesLoaded getBytesTotal load loaded onLoad send sendAndLoad toString	addRequestHeader fscommand MMExecute
syn keyword actionScriptXMLSocket			close connect onClose onConnect onData onXML
syn keyword actionScriptTextField			autoSize background backgroundColor border borderColor bottomScroll embedFonts _focusrect getDepth getFontList getNewTextFormat getTextFormat hscroll html htmlText maxChars maxhscroll maxscroll multiline onChanged onScroller onSetFocus _parent password _quality removeTextField replaceSel replaceText restrict selectable setNewTextFormat setTextFormat text textColor textHeight textWidth type variable wordWrap condenseWhite mouseWheelEnabled textFieldHeight textFieldWidth ascent descent
syn keyword actionScriptMethods				callee caller _alpha attachMovie beginFill beginGradientFill clear createEmptyMovieClip createTextField _currentframe curveTo _droptarget duplicateMovieClip enabled endFill focusEnabled _framesloaded getBounds globalToLocal gotoAndPlay gotoAndStop _height _highquality hitArea hitTest lineStyle lineTo loadMovie loadMovieNum loadVariables loadVariablesNum localToGlobal moveTo _name nextFrame onDragOut onDragOver onEnterFrame onKeyDown onKeyUp onKillFocus onMouseDown onMouseMove onMouseUp onPress onRelease onReleaseOutside onRollOut onRollOver onUnload play prevFrame removeMovieClip _rotation setMask _soundbuftime startDrag stopDrag swapDepths tabChildren tabIndex _target _totalframes trackAsMenu unloadMovie unloadMovieNum updateAfterEvent _url useHandCursor _visible _width _x _xmouse _xscale _y _ymouse _yscale tabEnabled asfunction call setInterval clearInterval setProperty stopAllSounds #initclip #endinitclip delete unescape escape eval apply prototype getProperty getTimer getURL getVersion ifFrameLoaded #include instanceof int new nextScene parseFloat parseInt prevScene print printAsBitmap printAsBitmapNum printNum scroll set targetPath tellTarget toggleHighQuality trace typeof isActive getInstanceAtDepth getNextHighestDepth getNextDepth getSWFVersion getTextSnapshot isFinite isNAN updateProperties _lockroot get install list uninstall showMenu onSelect builtInItems save zoom quality loop rewind forward_back customItems caption separatorBefore visible attachVideo bufferLength bufferTime currentFps onStatus pause seek setBuffertime smoothing time bytesLoaded bytesTotal addPage paperWidth paperHeight pageWidth pageHeight orientation loadClip unloadClip getProgress onLoadStart onLoadProgress onLoadComplete onLoadInit onLoadError styleSheet copy hideBuiltInItem transform activityLevel allowDomain allowInsecureDomain attachAudio bandwidth deblocking domain flush fps gain getLocal getRemote getSize index isConnected keyFrameInterval liveDelay loopback motionLevel motionTimeOut menu muted names onActivity onSync publish rate receiveAudio receiveVideo setFps setGain setKeyFrameInterval setLoopback setMode setMotionLevel setQuality setRate setSilenceLevel setUseEchoSuppression showSettings setClipboard silenceLevel silenceTimeOut useEchoSuppression
syn match   actionScriptBraces				"([{}])"
syn keyword actionScriptException 			try catch finally throw name message
syn keyword actionScriptXML					attributes childNodes cloneNode createElement createTextNode docTypeDecl status firstChild hasChildNodes lastChild insertBefore nextSibling nodeName nodeType nodeValue parentNode parseXML previousSibling removeNode xmlDecl ignoreWhite
syn keyword actionScriptArrayConstant 		CASEINSENSITIVE DESCENDING UNIQUESORT RETURNINDEXEDARRAY NUMERIC
syn keyword actionScriptStringConstant 		newline
syn keyword actionScriptEventConstant 		press release releaseOutside rollOver rollOut dragOver dragOut enterFrame unload mouseMove mouseDown mouseUp keyDown keyUp data
syn keyword actionScriptTextSnapshot 		getCount setSelected getSelected getText getSelectedText hitTestTextNearPos findText setSelectColor
syn keyword actionScriptID3 				id3 artist album songtitle year genre track comment COMM TALB TBPM TCOM TCON TCOP TDAT TDLY TENC TEXT TFLT TIME TIT1 TIT2 TIT3 TKEY TLAN TLEN TMED TOAL TOFN TOLY TOPE TORY TOWN TPE1 TPE2 TPE3 TPE4 TPOS TPUB TRCK TRDA TRSN TRSO TSIZ TSRX TSSE TYER WXXX
syn keyword actionScriptAS2 				class extends public private static interface implements import dynamic evaluate package const include use protected native internal override final 
syn keyword actionScriptStyleSheet 			parse parseCSS getStyle setStyle getStyleNames
syn keyword flash8Functions                             onMetaData onCuePoint flashdisplay flashexternal flashfilters flashgeom flashnet flashtext addCallback applyFilter browse cancel clone colorTransform  containsPoint containsRectangle copyChannel copyPixels createBox createGradientBox deltaTransformPoint dispose download draw equals fillRect floodFill generateFilterRect getColorBoundsRect getPixel getPixel32 identity inflate inflatePoint interpolate intersection intersects invert isEmpty loadBitmap merge noise normalize offsetPoint paletteMap perlinNoise pixelDissolve polar rotate scale setAdvancedAntialiasingTable setEmpty setPixel setPixel32 subtract threshold transformPoint translate union upload
syn keyword flash8Constants  				ALPHANUMERIC_FULL ALPHANUMERIC_HALF CHINESE JAPANESE_HIRAGANA JAPANESE_KATAKANA_FULL JAPANESE_KATAKANA_HALF KOREAN UNKNOWN
syn keyword flash8Properties 				appendChild cacheAsBitmap opaqueBackground scrollRect keyPress #initclip #endinitclip kerning letterSpacing onHTTPStatus lineGradientStyle IME windowlessDisable hasIME hideBuiltInItems onIMEComposition getEnabled setEnabled getConversionMode setConversionMode setCompositionString doConversion idMap antiAliasType available bottom bottomRight concatenatedColorTransform concatenatedMatrix creationDate creator fileList maxLevel modificationDate pixelBounds rectangle rgb top topLeft attachBitmap beginBitmapFill blendMode filters getRect scale9Grid gridFitType sharpness thickness
syn keyword flash8Classes 			BevelFilter BitmapData BitmapFilter BlurFilter ColorMatrixFilter ColorTransform ConvolutionFilter DisplacementMapFilter DropShadowFilter ExternalInterface FileReference FileReferenceList GlowFilter GradientBevelFilter GradientGlowFilter Matrix Point Rectangle TextRenderer StageAlign

syn keyword as3Properties 			compare pixelSnapping loaderInfo  mask  mouseX  mouseY  parent  root  rotation  scaleX  scaleY  x  y mouseChildren numChildren fontName  fontStyle  enumerate  hasGlyphs frame accessibilityImplementation focusRect mouseEnabled content loadeeInfo actionScriptVersion  applicationDomain  frameRate  loaderURL  parameters  securityRelationshipFlags  shared  swfVersion currentFrame  currentLabel  currentScene  framesLoaded  scenes  totalFrames labels numFrames downState hitTestState overState soundTransform upState buttonMode dropTarget focus showDefaultContextMenu  stageFocusRect  stageHeight  stageWidth alwaysShowSelection  bottomScrollV  caretIndex  defaultTextFormat  fontList  maxScrollH  maxScrollV  numLines  scrollH  scrollV  selectionBeginIndex  selectionEndIndex activity mouseTarget contextMenuOwner fullYear month hours minutes seconds milliseconds fullYearUTC monthUTC dateUTC hoursUTC minutesUTC secondsUTC millisecondsUTC timezoneOffset day dayUTC errorID prefix uri localName  ignoreProcessingInstructions ignoreWhitespace ignoreWhitespace ignoreWhitespace hasComplexContent hasSimpleContent inScopeNamespaces namespaceDeclarations nodeKind processingInstructions setChildren setLocalName setName setNamespace setSettings toXMLString ignoreComments attribute child childIndex children comments descendants defaultSettings elements prettyPrinting prettyIndent settings actionsList horizontalScrollPolicy verticalScrollPolicy horizontalLineScrollSize verticalLineScrollSize horizontalScrollPosition verticalScrollPosition maxHorizontalScrollPosition maxVerticalScrollPosition useBitmapScrolling horizontalPageScrollSize verticalPageScrollSize horizontalScrollBar verticalScrollBar percentLoaded autoLoad scaleContent maintainAspectRatio selected autoRepeat emphasized autoRepeat selectedColor hexValue editable showTextField colors imeMode rowCount  selectedIndex     labelField labelFunction selectedItem dropdown value dataProvider dropdownWidth prompt sortableColumns itemEditorInstance columns minColumnWidth rowHeight headerHeight showHeaders sortIndex sortDescending editedItemRenderer editedItemPosition label labelPlacement maximum minimum nextValue previousValue stepSize direction indeterminate percentComplete mode groupName group selectedData numRadioButtons scrollPosition minScrollPosition minScrollPosition maxScrollPosition pageSize pageScrollSize pageScrollSize direction allowMultipleSelection selectedIndices selectedItems lineScrollSize tickInterval snapInterval liveDragging displayAsPassword sourceField sourceFunction columnCount columnWidth innerWidth innerHeight scrollTarget listData sortable resizable itemEditor editorDataField dataField dataField cellRenderer headerRenderer headerText minWidth sortCompareFunction column FieldlineScrollSize sortOptions icon owner row mouseFocusEnabled focusManager itemRenderer reason rowIndex columnIndex item delta keyCode triggerEvent clickTarget autoReplace languageCodeArray stringIDArray onUpdate myInstance defaultButton defaultButtonEnabled nextTabIndex showFocusIndicator defaultButton defaultButtonEnabled nextTabIndex showFocusIndicator registerInstance getComponentStyle clearComponentStyle setComponentStyle fromXMLString getValue getSingleValue getYForX getCubicCoefficients getCubicRoots getQuadraticRoots fromXML  interpolateTransform interpolateColor setTint getValue easingFunction functionName setValue getTween getScaleX setScaleX getScaleY setScaleY getSkewXRadians setSkewXRadians getSkewYRadians setSkewYRadians getSkewX setSkewX getSkewY getSkewY setSkewY getRotationRadians setRotationRadians getRotation setRotation rotateAroundInternalPoint rotateAroundExternalPoint matchInternalPointWithExternal getCurrentKeyframe getNextKeyframe setValue getColorTransform getFilters addKeyframe interpolateFilters interpolateFilter easeIn easeOut easeInOut easeNone transformationPoint autoRewind positionMatrix repeatCount motion isPlaying orientToPath points a b c d brightness tintColor tintMultiplier points affectsTweenable skewX skewY tweens easeQuadPercent tweenScale tweenSnap tweenSync firstFrame rotateDirection rotateTimes blank keyframes keyframesCompact easeNone ease elementType symbolName instanceName linkageID dimensions resume contentAppearance obj prop func begin useSeconds looping finish vp captionCuePointObject captionTarget playWhenEnoughDownloaded seekSeconds seekPercent playheadPercentage preview activeVideoPlayerIndex autoPlay bitrate bufferingBar bufferingBarHidesAndDisablesOthers backButton cuePoints forwardButton fullScreenBackgroundColor fullScreenButton fullScreenSkinDelay fullScreenTakeOver idleTimeout isRTMP isLive metadata metadataLoaded muteButton ncMgr pauseButton playButton playheadTime playheadUpdateInterval playPauseButton preferredHeight preferredWidth progressInterval registrationX registrationY registrationWidth registrationHeight scrubbing seekBar seekBarInterval seekBarScrubTolerance seekToPrevOffset skin skinAutoHide skinBackgroundAlpha skinBackgroundColor skinFadeTime skinScaleMaximum stateResponsive stopButton totalTime visibleVideoPlayerIndex volume volumeBar volumeBarIntervalvolumeBarScrubTolerance showCaptions autoLayout captionTargetName captionButton flvPlaybackName videoPlayerIndex simpleFormatting helperDone videoPlayer timeout streamName streamLength streamWidth volumeBarInterval volumeBarScrubTolerance streamHeight oldBounds oldRegistrationBounds info fallbackServerName code ncConnected ncReconnected iNCManagerClass netStreamClientClass lock unlock rect  accessibilityProperties doubleClickEnabled contentLoaderInfo sharedEvents sameDomain childAllowsParent parentAllowsChild bytes currentLabels displayState fullScreenSourceRect fullScreenWidth fullScreenHeight activating isDefaultPrevented bubbles volumeBarInterval videoHeight cancelable currentTarget relatedObject shiftKey charCode keyLocation ctrlKey altKey localX localY buttonDown stageX stageY level changeList objectID distance angle highlightColor highlightAlpha shadowColor shadowAlpha blurX blurY knockout strength matrixX matrixY divisor bias preserveAlpha mapBitmap mapPoint componentX componentY hideObject alphas ratios redMultiplier greenMultiplier blueMultiplier alphaMultiplier redOffset greenOffset blueOffset alphaOffset tx ty offset songName leftPeak rightPeak videoWidth extension macType client connected client defaultObjectEncoding objectEncoding proxyType connectedProxyType usingTLS bytesAvailable endian dataFormat method requestHeaders hasTLS conversionMode securityDomain currentDomain totalMemory fontSize insideCutoff outsideCutoff sandboxType styleNames useRichTextClipboard displayMode charCount forwardAndBack isAccessible numLock nextNameIndex nextName delay  currentCount running namespaceURI

syn keyword as3Classes				Bitmap BitmapDataChannel CapsStyle DisplayObject DisplayObjectContainer FrameLabel GradientType Graphics InteractiveObject InterpolationMethod JointStyle LineScaleMode Loader MorphShape Scene Shape SimpleButton SpreadMethod Sprite StageQuality StageScaleMode StaticText TextFieldAutoSize TextFieldType ActivityEvent ContextMenuEvent RegExp Namespace uint XMLList constructor QName XMLUI AccImpl ButtonAccImpl CheckBoxAccImpl ComboBoxAccImpl DataGridAccImpl LabelButtonAccImpl ListAccImpl RadioButtonAccImpl SelectableListAccImpl TileListAccImpl UIComponentAccImpl BaseScrollPane ScrollPane UILoader BaseButton ButtonLabelPlacement CheckBox ColorPicker ComboBox DataGrid Label LabelButton NumericStepper ProgressBar ProgressBarDirection ProgressBarMode RadioButton RadioButtonGroup ScrollBar ScrollBarDirection ScrollPolicy SelectableList Slider SliderDirection TextArea TextInput TileList UIScrollBar DataGridCellEditor DataGridColumn HeaderRenderer CellRenderer ICellRenderer ImageCell TileListData IndeterminateBar DataChangeType InvalidationType UIComponent SimpleCollectionItem DataGridEventReason TileListCollectionItem InteractionInputType SliderEventClickTarget Locale LivePreviewParent IFocusManager IFocusManagerComponent IFocusManagerGroup StyleManager Animator MotionEvent BezierEase BezierSegment CustomEase FunctionEase ITween Keyframe MatrixTransformer FLVPlayback FLVPlaybackCaptioning NCManager VideoScaleMode VideoState SimpleEase Tweenables Back Bounce Circular Cubic Elastic Exponential Quadratic Quartic Quintic Sine Blinds Fade Fly Iris Photo Squeeze Transition TransitionManager Tween Wipe Strong CuePointType INCManager NCManagerNative VideoAlign AccessibilityProperties AVM1Movie IBitmapDrawable StageDisplayState LoaderInfo EventDispatcher EventPhase IEventDispatcher BitmapFilterQuality BitmapFilterType DisplacementMapFilterMode ID3Info SoundChannel SoundLoaderContext SoundMixer FileFilter IDynamicPropertyOutput IDynamicPropertyWriter ObjectEncoding Responder SharedObjectFlushStatus DoynamicPropertyWriter Socket URLLoader URLLoaderDataFormat URLRequest URLRequestHeader URLRequestMethod URLStream URLVariables PrintJobOptions PrintJobOrientation IMEConversionMode LoaderContext SecurityDomain SecurityPanel CSMSettings FontType TextColorType TextDisplayMode TextFormatAlign TextLineMetrics ContextMenuBuiltInItems ByteArray Dictionary IDataInput IDataOutput IExternalizable Proxy XMLDocument XMLNodeType
syn keyword as3Packages					flash display errors events fl mx utils adobe containers controls dataGridClasses listClasses progressBarClasses core lang livepreview managers motion easing transitions external geom media net printing profiler ui
syn keyword as3Functions			getPixels setPixels hitTestObject hitTestPoint addChild  addChildAtareInaccessibleObjectsUnderPoint getChildAt  getChildByName  getChildIndex  getObjectsUnderPoint  removeChild  removeChildAt  setChildIndex addChildAt  areInaccessibleObjectsUnderPoint drawCircle  drawEllipse  drawRect  drawRoundRect  drawRoundRectComplex releaseCapture setCapture loadBytes invalidate  isFocusInaccessible appendText  getCharBoundaries  getCharIndexAtPoint  getFirstCharInParagraph  getImageReference  getLineIndexAtPoint  getLineIndexOfChar  getLineLength  getLineMetrics  getLineOffset  getLineText  getParagraphLength replaceSelectedText every filter forEach map  some toLocaleString toDateString toTimeString toLocaleString toLocaleDateString toLocaleTimeString toUTCString getStackTrace toFixed toExponential toPrecision decodeURI decodeURIComponent encodeURI encodeURIComponent isXMLName hasOwnProperty propertyIsEnumerable isPrototypeOf setPropertyIsEnumerable exec test dotall extended global ignoreCase lastIndex source localeCompare replace match search toLocaleLowerCase toLocaleUpperCase addNamespace insertChildAfter insertChildBefore prependChild removeNamespace installActions uninstallActions getActions accept enableAccessibility getStyleDefinition refreshPane scrollDrag setSize setMouseState drawFocus toggle itemToLabel addItem addItemAt removeAll removeItem removeItemAt getItemAt replaceItemAt sortItems sortItemsOn addColumnAt removeColumnAt removeAllColumns getColumnAt getColumnIndex getColumnCount spaceColumnsEqually editField itemToCellRenderer createItemEditor destroyItemEditor getCellRendererAt scrollToIndex resizableColumns addColumn iconField iconFunction setProgress reset getGroup addRadioButton removeRadioButton getRadioButtonIndex getRadioButtonAt setScrollProperties clearSelection invalidateList invalidateItem invalidateItemAt isItemSelected scrollToSelected scrollToSelected setRendererStyle getRendererStyle clearRendererStyle getNextIndexAtLetter mergeStyles clearStyle move validateNow drawNow addItemsAt addItems getItemIndex replaceItem toArray getDefaultLang setDefaultLang addXMLPath addDelayedInstance checkXMLStatus setLoadCallback loadString loadStringEx setString initialize loadLanguageXML getNextFocusManagerComponent showFocus hideFocus findFocusManagerComponent showFocus hideFocus findFocusManagerComponent getNextFocusManagerComponent startTransition continueTo yoyo fforward setScale seekToNavCuePoint seekToNextNavCuePoint seekToPrevNavCuePoint addASCuePoint removeASCuePoint findCuePoint findNearestCuePoint findNearestCuePoint setFLVCuePointEnabled isFLVCuePointEnabled bringVideoPlayerToFront getVideoPlayer closeVideoPlayer enterFullScreenDisplayState findNextCuePointWithName connectToURL connectAgain reconnect swapChildrenAt swapChildren getLoaderInfoByDefinition addEventListener dispatchEvent hasEventListener willTrigger swapChildrenAt formatToString stopPropagation stopImmediatePropagation preventDefault removeEventListener marshallExceptions getCamera getMicrophone containsRect isBuffering checkPolicyFile stopAll computeSpectrum areSoundsInaccessible leftToLeft leftToRight rightToRight rightToLeft pan attachNetStream attachCamera writeDynamicProperty writeDynamicProperties addHeader togglePause registerClassAlias getClassByAlias navigateToURL sendToURL setDirty readBytes writeBytes writeBoolean writeByte writeShort writeInt writeUnsignedInt writeFloat writeDouble writeMultiByte writeUTF writeUTFBytes readBoolean readByte readUnsignedByte readShort readUnsignedShort readInt readUnsignedInt readFloat readDouble readMultiByte readUTF readUTFBytes writeObject readObject decode showRedrawRegions getDefinition hasDefinition currentDomain parentDomain loadPolicyFile exit gc enumerateFonts registerFont getTextRunInfo compress uncompress writeExternal readExternal describeType getQualifiedClassName getDefinitionByName getQualifiedSuperclassName escapeMultiByte unescapeMultiByte setTimeout clearTimeout callProperty hasProperty deleteProperty getDescendants isAttribute getNamespaceForPrefix getPrefixForNamespace 

syn keyword as3Constants			ALPHA BLUE GREEN RED DARKEN  DIFFERENCE  ERASE  HARDLIGHT  LAYER  LIGHTEN  MULTIPLY  NORMAL  OVERLAY  SCREEN  NONE  SQUARE LINEAR RADIAL LINEAR_RGB BEVEL MITER HORIZONTAL VERTICAL LOADER_SECURITY_CHILD_ALLOWS_PARENT  LOADER_SECURITY_PARENT_ALLOWS_CHILD  LOADER_SECURITY_SAME_DOMAIN ALWAYS AUTO NEVER PAD REFLECT REPEAT BOTTOM_LEFT  BOTTOM_RIGHT  TOP_LEFT  TOP_RIGHT  BEST  HIGH  LOW  MEDIUM  EXACT_FIT  NO_BORDER  NO_SCALE  SHOW_ALL CENTER MENU_ITEM_SELECT  MENU_SELECT  ACTIVATE  ADDED  CHANGE  COMPLETE  DEACTIVATE  ENTER_FRAME  INIT  MOUSE_LEAVE  OPEN  REMOVED  RENDER  RESIZE  SELECT  SOUND_COMPLETE  TAB_CHILDREN_CHANGE  TAB_ENABLED_CHANGE  TAB_INDEX_CHANGE  TIMER_COMPLETE AT_TARGET  BUBBLING_PHASE  CAPTURING_PHASE  FOCUS_IN  FOCUS_OUT  KEY_FOCUS_CHANGE  MOUSE_FOCUS_CHANGE  HTTP_STATUS  IME_COMPOSITION  IO_ERROR  KEY_DOWN  KEY_UP  CLICK  DOUBLE_CLICK  MOUSE_DOWN  MOUSE_MOVE  MOUSE_OUT  MOUSE_OVER  MOUSE_UP  MOUSE_WHEEL  ROLL_OUT  ROLL_OVER  NET_STATUS  POLICY_FILE  PROGRESS  SOCKET_DATA  SECURITY_ERROR  SYNC  LINK  TEXT_INPUT  TIMER  FULL  INNER  OUTER  CLAMP  IGNORE  WRAP  BINARY  VARIABLES  AMF0  AMF3  POST  LANDSCAPE  PORTRAIT  LOCAL_STORAGE  PRIVACY  SETTINGS_MANAGER  ADVANCED  GLOBAL_ADVANCED_ANTIALIASING_OFF  GLOBAL_ADVANCED_ANTIALIASING_ON  GLOBAL_ADVANCED_ANTIALIASING_TEXTFIELD_CONTROL  DARK_COLOR  LIGHT_COLOR  BOLD_ITALIC  PIXEL  SUBPIXEL  JUSTIFY  CAPS_LOCK  F1  F10  F11  F12  F13  F14  F15  F2  F3  F4  F5  F6  F7  F8  F9  NUMPAD_0  NUMPAD_1  NUMPAD_2  NUMPAD_3  NUMPAD_4  NUMPAD_5  NUMPAD_6  NUMPAD_7  NUMPAD_8  NUMPAD_9  NUMPAD_ADD  NUMPAD_DECIMAL  NUMPAD_DIVIDE  NUMPAD_ENTER  NUMPAD_MULTIPLY  NUMPAD_SUBTRACT  PAGE_DOWN  PAGE_UP  NUM_PAD  STANDARD  BIG_ENDIAN  LITTLE_ENDIAN  ELEMENT_NODE  TEXT_NODE BUTTON_DOWN ITEM_ROLL_OUT ITEM_ROLL_OVER ITEM_FOCUS_OUT ITEM_FOCUS_IN ITEM_EDIT_END ITEM_EDIT_BEGIN ITEM_EDIT_BEGINNING COLUMN_STRETCH HEADER_RELEASE LABEL_CHANGE MANUAL POLLED OFF ITEM_DOUBLE_CLICK ITEM_CLICK THUMB_DRAG THUMB_RELEASE THUMB_PRESS ALL STYLES RENDERER_STYLES STATE DATA_CHANGE PRE_DATA_CHANGE MOVE DATA_CHANGE PRE_DATA_CHANGE INVALIDATE_ALL REMOVE REMOVE_ALL CANCELLED OTHER NEW_COLUMN NEW_ROW KEYBOARD THUMB TIME_CHANGE MOTION_UPDATE MOTION_START MOTION_END CW CCW SCALE_X SCALE_Y SKEW_X SKEW_Y CIRCLE OUT MOTION_STOP MOTION_START MOTION_RESUME MOTION_LOOP MOTION_FINISH MOTION_CHANGE AUTO_LAYOUT CAPTION_CHANGE CAPTION_TARGET_CREATED NAVIGATION FLV ACTIONSCRIPT SHORT_VERSION SOUND_UPDATE STOPPED_STATE_ENTERED STATE_CHANGE SKIN_LOADED SKIN_ERROR SEEKED SCRUB_START SCRUB_FINISH LAYOUT READY PLAYHEAD_UPDATE PLAYING_STATE_ENTERED PAUSED_STATE_ENTERED METADATA_RECEIVED FAST_FORWARD CUE_POINT BUFFERING_STATE_ENTERED AUTO_REWOUND AUTO_LAYOUT SHORT_VERSION CAPTION_TARGET_CREATED CAPTION_CHANGE LAYOUT METADATA_RECEIVED CUE_POINT VERSION SHORT_VERSION DEFAULT_TIMEOUT NO_CONNECTION ILLEGAL_CUE_POINT INVALID_SEEK INVALID_SOURCE INVALID_XML NO_BITRATE_MATCH DELETE_DEFAULT_PLAYER INCMANAGER_CLASS_UNSET NULL_URL_LOAD MISSING_SKIN_STYLE UNSUPPORTED_PROPERTY NETSTREAM_CLIENT_CLASS_UNSET MAINTAIN_ASPECT_RATIO NO_SCALE EXACT_FIT DISCONNECTED STOPPED PLAYING PAUSED BUFFERING LOADING CONNECTION_ERROR REWINDING SEEKING RESIZING ACTIONSCRIPT2 ACTIONSCRIPT3 REMOVED_FROM_STAGE ADDED_TO_STAGE FULL_SCREEN NORMAL FLASH1 FLASH2 FLASH3 FLASH4 FLASH5 FLASH6 FLASH7 FLASH8 FLASH9 FLASH10 ASYNC_ERROR UPLOAD_COMPLETE_DATA FULLSCREEN FLUSHED PENDING REMOTE LOCAL_WITH_FILE LOCAL_WITH_NETWORK LOCAL_TRUSTED REGULAR EMBEDDED DEVICE LCD CRT
syn keyword actionScriptInclude #include #initClip #endInitClip
syn keyword as3Errors EOFError  IllegalOperationError  IOError  MemoryError  ScriptTimeoutError  StackOverflowError ArgumentError DefinitionError EvalError RangeError ReferenceError SecurityError SyntaxError TypeError URIError VerifyError VideoError InvalidSWFError
syn keyword as3Events	DataEvent ErrorEvent Event ScrollEvent ProgressEvent SecurityErrorEvent ComponentEvent ProgressEvent IOErrorEvent ComponentEvent ColorPickerEvent ListEvent MouseEvent TextEvent DataChangeEvent HTTPStatusEvent IMEEvent TimerEvent TweenEvent AutoLayoutEvent CaptionChangeEvent CaptionTargetEvent SoundEvent VideoEvent  SkinErrorEvent LayoutEvent VideoProgressEvent MetadataEvent IVPEvent KeyboardEvent FocusEvent FullScreenEvent AsyncErrorEvent FocusEvent KeyboardEvent NetStatusEvent StatusEvent SyncEvent DataGridEvent SliderEvent

" catch errors caused by wrong parenthesis
syn match   actionScriptInParen     contained "[{}]"
syn region  actionScriptParen       transparent start="(" end=")" contains=actionScriptParen,actionScript.*
syn match   actionScrParenError  ")"
"end as3
"
" The default highlighting.
if version >= 508 || !exists("did_haxe_syn_inits")
  if version < 508
    let did_haxe_syn_inits = 1
  endif
  HaxeHiLink haxeFuncDef        Function
  HaxeHiLink haxeBraces     Function
  HaxeHiLink haxeBranch     Conditional
  HaxeHiLink haxeUserLabelRef   haxeUserLabel
  HaxeHiLink haxeLabel      Label
  HaxeHiLink haxeUserLabel      Label
  HaxeHiLink haxeConditional    Conditional
  HaxeHiLink haxeRepeat     Repeat
  HaxeHiLink haxeExceptions     Exception
  HaxeHiLink haxeAssert     Statement
  HaxeHiLink haxeStatic MoreMsg
  HaxeHiLink haxeStorageClass   StorageClass
  HaxeHiLink haxeMethodDecl     haxeStorageClass
  HaxeHiLink haxeClassDecl      StorageClass
  HaxeHiLink haxeScopeDecl      StorageClass
  HaxeHiLink haxeBoolean        Boolean
  HaxeHiLink haxeSpecial        Special
  HaxeHiLink haxeSpecialError   Error
  HaxeHiLink haxeSpecialCharError   Error
  HaxeHiLink haxeString     String
  HaxeHiLink haxeSingleString   String
  HaxeHiLink haxeEreg Special
  HaxeHiLink haxeEregEscape Special
  HaxeHiLink haxeCharacter      Character
  HaxeHiLink haxeSpecialChar    SpecialChar
  HaxeHiLink haxeNumber     Number
  HaxeHiLink haxeError      Error
  HaxeHiLink haxeStringError    Error
  HaxeHiLink haxeStatement      Statement
  HaxeHiLink haxeOperator       Operator
  HaxeHiLink haxeComment        Comment
  HaxeHiLink haxeDocComment     Comment
  HaxeHiLink haxeLineComment    Comment
  HaxeHiLink haxeConstant       Constant
  HaxeHiLink haxeTypedef        Typedef
  HaxeHiLink haxeTodo       Todo
  HaxeHiLink haxeLangClass      Special
  HaxeHiLink haxeFunction       Function

  HaxeHiLink haxeCommentTitle   SpecialComment
  HaxeHiLink haxeDocTags        Special
  HaxeHiLink haxeDocParam       Function
  HaxeHiLink haxeCommentStar    haxeComment

  HaxeHiLink haxeType       Type
  HaxeHiLink haxeExternal       Include

  HaxeHiLink htmlComment        Special
  HaxeHiLink htmlCommentPart    Special
  HaxeHiLink haxeSpaceError     Error

  HaxeHiLink haxeCondIf Macro
  HaxeHiLink haxeCondElse Macro
  HaxeHiLink haxeCondEnd Macro
  HaxeHiLink haxeCondError Error
endif

delcommand HaxeHiLink

" as3 highlighting
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_actionscript_syn_inits")
  if version < 508
    let did_actionscript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink actionScriptComment		Comment
  HiLink actionScriptLineComment	Comment
  HiLink actionScriptSpecial		Special
  HiLink actionScriptStringS		String
  HiLink actionScriptStringD		String
  HiLink actionScriptCharacter		Character
  HiLink actionScriptSpecialCharacter	actionScriptSpecial
  HiLink actionScriptNumber		actionScriptValue
  HiLink actionScriptBraces		Function
  HiLink actionScriptError		Error
  HiLink actionScrParenError		actionScriptError
  HiLink actionScriptInParen		actionScriptError
  HiLink actionScriptConditional	Conditional
  HiLink actionScriptRepeat		Repeat
  HiLink actionScriptCase		Label
  HiLink actionScriptConstructor	Operator
  HiLink actionScriptObjects		Operator
  HiLink actionScriptStatement		Statement
  HiLink actionScriptFunction		Function
  HiLink actionScriptValue		Boolean
  HiLink actionScriptArray		Type
  HiLink actionScriptDate		Type
  HiLink actionScriptMath		Type
  HiLink actionScriptNumberObj		Type
  HiLink actionScriptObject		Function
  HiLink actionScriptString		Type
  HiLink actionScriptColor		Type
  HiLink actionScriptKey		Type
  HiLink actionScriptMouse		Type
  HiLink actionScriptSelection		Type
  HiLink actionScriptSound		Type
  HiLink actionScriptStage		Type
  HiLink actionScriptSystem		Type
  HiLink actionScriptTextFormat		Type
  HiLink actionScriptCommunication	Type
  HiLink actionScriptXMLSocket		Type
  HiLink actionScriptTextField		Type
  HiLink actionScriptMethods		Statement
  HiLink actionScriptException		Exception
  HiLink actionScriptXML		Type
  HiLink actionScriptArrayConstant	Constant
  HiLink actionScriptStringConstant	Constant
  HiLink actionScriptEventConstant	Constant
  HiLink actionScriptTextSnapshot	Type
  HiLink actionScriptID3		Type
  HiLink actionScriptAS2		Function
  HiLink actionScriptStyleSheet		Type
  HiLink flash8Constants		Constant
  HiLink flash8Functions		Function
  HiLink flash8Properties		Type
  HiLink flash8Classes 			Type
  HiLink actionScriptInclude		Include
  HiLink as3Packages			Constant
  HiLink as3Classes			Constant
  HiLink as3Properties			Type
  HiLink as3Functions			Function
  HiLink as3Constants			Type
  HiLink as3Errors			Constant
  HiLink as3Events			Constant
  delcommand HiLink
endif

"end as3 highlighting
let b:current_syntax = "haxe"

if main_syntax == 'haxe'
  unlet main_syntax
endif

let b:spell_options="contained"

" vim: ts=8

