object fAtualiza: TfAtualiza
  Left = 379
  Top = 277
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Download de Arquivos...'
  ClientHeight = 164
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GridPanel1: TGridPanel
    Left = 128
    Top = 0
    Width = 425
    Height = 122
    Align = alClient
    BevelOuter = bvNone
    Caption = 'GridPanel1'
    ColumnCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 90.000000000000000000
      end
      item
        Value = 100.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 130.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = img1
        Row = 1
        RowSpan = 2
      end
      item
        Column = 0
        ColumnSpan = 3
        Control = sTitulo
        Row = 0
      end
      item
        Column = 1
        Control = pbProgresso
        Row = 1
      end
      item
        Column = 2
        Control = sProgresso
        Row = 1
      end
      item
        Column = 1
        Control = pbProgressoT
        Row = 2
      end
      item
        Column = 2
        Control = sProgressoT
        Row = 2
      end>
    RowCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 35.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 35.000000000000000000
      end
      item
        Value = 100.000000000000000000
      end>
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 41
    ExplicitWidth = 512
    object img1: TbsPngImageView
      Left = 0
      Top = 50
      Width = 90
      Height = 70
      DoubleBuffered = False
      ReflectionEffect = False
      PngImageList = DM.ico_64x64
      ImageIndex = 3
      Align = alClient
      Center = True
      ExplicitWidth = 64
      ExplicitHeight = 64
    end
    object sTitulo: TbsSkinLabel
      AlignWithMargins = True
      Left = 10
      Top = 0
      Width = 412
      Height = 47
      Margins.Left = 10
      Margins.Top = 0
      HintImageIndex = 0
      TabOrder = 0
      SkinData = DM.bsSkinData1
      SkinDataName = 'label'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      Transparent = False
      ShadowEffect = False
      ShadowColor = clBlack
      ShadowOffset = 0
      ShadowSize = 3
      ReflectionEffect = False
      ReflectionOffset = -5
      EllipsType = bsetNoneEllips
      UseSkinSize = True
      UseSkinFontColor = True
      BorderStyle = bvNone
      Align = alClient
      Caption = '..........'
      AutoSize = False
      ExplicitWidth = 499
    end
    object pbProgresso: TProgressBar
      AlignWithMargins = True
      Left = 93
      Top = 57
      Width = 199
      Height = 21
      Margins.Top = 7
      Margins.Bottom = 7
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 286
    end
    object sProgresso: TbsSkinLabel
      AlignWithMargins = True
      Left = 298
      Top = 57
      Width = 124
      Height = 21
      Margins.Top = 7
      Margins.Bottom = 7
      HintImageIndex = 0
      TabOrder = 2
      SkinData = DM.bsSkinData1
      SkinDataName = 'label'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      Transparent = False
      ShadowEffect = False
      ShadowColor = clBlack
      ShadowOffset = 0
      ShadowSize = 3
      ReflectionEffect = False
      ReflectionOffset = -5
      EllipsType = bsetNoneEllips
      UseSkinSize = True
      UseSkinFontColor = True
      BorderStyle = bvNone
      Align = alClient
      Caption = '          '
      AutoSize = False
      ExplicitLeft = 385
    end
    object pbProgressoT: TProgressBar
      AlignWithMargins = True
      Left = 93
      Top = 92
      Width = 199
      Height = 21
      Margins.Top = 7
      Margins.Bottom = 7
      Align = alClient
      TabOrder = 3
      ExplicitWidth = 286
    end
    object sProgressoT: TbsSkinLabel
      AlignWithMargins = True
      Left = 298
      Top = 92
      Width = 124
      Height = 21
      Margins.Top = 7
      Margins.Bottom = 7
      HintImageIndex = 0
      TabOrder = 4
      SkinData = DM.bsSkinData1
      SkinDataName = 'label'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      Transparent = False
      ShadowEffect = False
      ShadowColor = clBlack
      ShadowOffset = 0
      ShadowSize = 3
      ReflectionEffect = False
      ReflectionOffset = -5
      EllipsType = bsetNoneEllips
      UseSkinSize = True
      UseSkinFontColor = True
      BorderStyle = bvNone
      Align = alClient
      Caption = '          '
      AutoSize = False
      ExplicitLeft = 385
    end
  end
  object bsSkinPanel1: TbsSkinPanel
    Left = 0
    Top = 122
    Width = 553
    Height = 42
    HintImageIndex = 0
    TabOrder = 2
    SkinData = DM.bsSkinData1
    SkinDataName = 'panel'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 13
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    EmptyDrawing = False
    RibbonStyle = False
    ImagePosition = bsipDefault
    TransparentMode = False
    CaptionImageIndex = -1
    RealHeight = -1
    AutoEnabledControls = True
    CheckedMode = False
    Checked = False
    DefaultAlignment = taLeftJustify
    DefaultCaptionHeight = 20
    BorderStyle = bvNone
    CaptionMode = False
    RollUpMode = False
    RollUpState = False
    NumGlyphs = 1
    Spacing = 2
    Caption = 'bsSkinPanel1'
    Align = alBottom
    object bsSkinButton2: TbsSkinButton
      AlignWithMargins = True
      Left = 456
      Top = 5
      Width = 92
      Height = 32
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      HintImageIndex = 0
      TabOrder = 1
      SkinData = DM.bsSkinData1
      SkinDataName = 'button'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      Transparent = False
      CheckedMode = False
      ImageList = DM.ico_24x24
      ImageIndex = 1
      AlwaysShowLayeredFrame = False
      UseSkinSize = False
      UseSkinFontColor = True
      RepeatMode = False
      RepeatInterval = 100
      AllowAllUp = False
      TabStop = True
      CanFocused = True
      Down = False
      GroupIndex = 0
      Caption = 'Cancelar'
      NumGlyphs = 1
      Spacing = 1
      Align = alRight
      OnClick = bsSkinButton2Click
    end
    object sStatus: TbsSkinLabel
      AlignWithMargins = True
      Left = 10
      Top = 0
      Width = 438
      Height = 39
      Margins.Left = 10
      Margins.Top = 0
      HintImageIndex = 0
      TabOrder = 0
      SkinData = DM.bsSkinData1
      SkinDataName = 'label'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      Transparent = False
      ShadowEffect = False
      ShadowColor = clBlack
      ShadowOffset = 0
      ShadowSize = 3
      ReflectionEffect = False
      ReflectionOffset = -5
      EllipsType = bsetNoneEllips
      UseSkinSize = True
      UseSkinFontColor = True
      BorderStyle = bvNone
      Align = alClient
      Caption = '..........'
      AutoSize = False
    end
  end
  object bsBusinessSkinForm1: TbsBusinessSkinForm
    UseRibbon = False
    ShowMDIScrollBars = True
    WindowState = wsNormal
    QuickButtons = <
      item
        AllowAllUp = False
        Down = False
        ImageIndex = 15
        Enabled = True
        Visible = False
        Caption = 'Atualizar Colet'#226'nea'
        Position = bsqbpLeft
      end>
    QuickButtonsShowHint = False
    QuickButtonsShowDivider = True
    ClientInActiveEffect = False
    ClientInActiveEffectType = bsieSemiTransparent
    DisableSystemMenu = False
    AlwaysResize = False
    PositionInMonitor = bspScreenCenter
    UseFormCursorInNCArea = False
    MaxMenuItemsInWindow = 0
    ClientWidth = 0
    ClientHeight = 0
    HideCaptionButtons = True
    HideCloseButton = False
    AlwaysShowInTray = False
    LogoBitMapTransparent = False
    AlwaysMinimizeToTray = False
    UseSkinFontInMenu = True
    UseSkinFontInCaption = True
    UseSkinSizeInMenu = True
    ShowIcon = False
    MaximizeOnFullScreen = False
    AlphaBlend = False
    AlphaBlendAnimation = False
    AlphaBlendValue = 200
    ShowObjectHint = False
    MenusAlphaBlend = False
    MenusAlphaBlendAnimation = False
    MenusAlphaBlendValue = 200
    DefCaptionFont.Charset = DEFAULT_CHARSET
    DefCaptionFont.Color = clBtnText
    DefCaptionFont.Height = 13
    DefCaptionFont.Name = 'Tahoma'
    DefCaptionFont.Style = [fsBold]
    DefInActiveCaptionFont.Charset = DEFAULT_CHARSET
    DefInActiveCaptionFont.Color = clBtnShadow
    DefInActiveCaptionFont.Height = 13
    DefInActiveCaptionFont.Name = 'Tahoma'
    DefInActiveCaptionFont.Style = [fsBold]
    DefMenuItemHeight = 20
    DefMenuItemFont.Charset = DEFAULT_CHARSET
    DefMenuItemFont.Color = clWindowText
    DefMenuItemFont.Height = 13
    DefMenuItemFont.Name = 'Tahoma'
    DefMenuItemFont.Style = []
    UseDefaultSysMenu = True
    SkinData = DM.bsSkinData1
    MinimizeApplication = False
    MinHeight = 0
    MinWidth = 0
    MaxHeight = 0
    MaxWidth = 0
    MinClientHeight = 0
    MinClientWidth = 0
    MaxClientHeight = 0
    MaxClientWidth = 0
    Magnetic = False
    MagneticSize = 5
    BorderIcons = []
    Left = 230
    Top = 12
  end
  object tmrFecha: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrFechaTimer
    Left = 104
    Top = 24
  end
end
