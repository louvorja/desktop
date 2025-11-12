object fVideoOn: TfVideoOn
  Left = 0
  Top = 0
  Caption = '.'
  ClientHeight = 524
  ClientWidth = 945
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object wbVideo: TWebBrowser
    Left = 0
    Top = 0
    Width = 945
    Height = 184
    Align = alClient
    TabOrder = 1
    OnDocumentComplete = wbVideoDocumentComplete
    ExplicitLeft = 64
    ExplicitTop = 56
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C000000AB610000041300000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object mmHTML: TMemo
    Left = 0
    Top = 184
    Width = 945
    Height = 340
    Align = alBottom
    Lines.Strings = (
      '<html>'
      '  <head>'
      '    <title>Player</title>'
      '    <style>'
      '      html, body, .video-wrap {'
      '        margin: 0;'
      '        padding: 0;'
      '        background: #000;'
      '        width: 100%;'
      '        height: 100%;'
      '        overflow: hidden;'
      '      }'
      '      iframe {'
      '        position: absolute;'
      '        width: 100%;'
      '        height: 100%;'
      '        top: 0;'
      '        left: 0;'
      '        border: 0;'
      '      }'
      '    </style>'
      '  </head>'
      '  <body>'
      '    <div class="video-wrap" id="player"></div>'
      ''
      '    <script type="text/javascript">'
      '      function getVideoId() {'
      '        var query = window.location.search;'
      '        if (!query || query.length < 2) return "";'
      '        return decodeURIComponent(query.substring(1));'
      '      }'
      ''
      '      var videoId = getVideoId();'
      ''
      '      if (!videoId) {'
      '        document.body.innerHTML ='
      
        '          '#39'<div style="color:white;text-align:center;font-family' +
        ':sans-serif;margin-top:30%;">'#39' +'
      '          '#39'<p>Nenhum ID de v'#237'deo foi informado.</p>'#39' +'
      '          '#39'<p>Use por exemplo: <code>?dQw4w9WgXcQ</code></p>'#39' +'
      '          '#39'</div>'#39';'
      '      } else {'
      '        var iframe = document.createElement("iframe");'
      
        '        iframe.src = "https://api.louvorja.com.br/player?v=" + e' +
        'ncodeURIComponent(videoId);'
      
        '        iframe.setAttribute("allow", "accelerometer; autoplay; c' +
        'lipboard-write; encrypted-media; gyroscope; picture-in-picture")' +
        ';'
      '        iframe.setAttribute("allowFullscreen", "true");'
      '        iframe.setAttribute("frameborder", "0");'
      '        iframe.setAttribute("loading", "lazy");'
      '        document.getElementById("player").appendChild(iframe);'
      '      }'
      '    </script>'
      '  </body>'
      '</html>'
      '')
    ScrollBars = ssBoth
    TabOrder = 2
    Visible = False
    WordWrap = False
    ExplicitTop = 190
  end
  object pnlLoading: TPanel
    Left = 0
    Top = 0
    Width = 945
    Height = 184
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlLoading'
    Color = clBlack
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 452
    ExplicitHeight = 174
    object lblLoading: TbsSkinLabel
      Left = 0
      Top = 0
      Width = 945
      Height = 184
      HintImageIndex = 0
      TabOrder = 0
      SkinData = DM.bsSkinData1
      SkinDataName = 'label'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWhite
      DefaultFont.Height = 21
      DefaultFont.Name = 'Arial Rounded MT Bold'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      Transparent = True
      ShadowEffect = True
      ShadowColor = clWhite
      ShadowOffset = 0
      ShadowSize = 3
      ReflectionEffect = False
      ReflectionOffset = -5
      EllipsType = bsetNoneEllips
      UseSkinSize = False
      UseSkinFontColor = False
      BorderStyle = bvNone
      Alignment = taCenter
      Align = alClient
      Caption = 'Carregando...'
      AutoSize = True
      ExplicitWidth = 452
      ExplicitHeight = 174
    end
  end
end
