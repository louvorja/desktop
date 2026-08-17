object fListaMusica: TfListaMusica
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'fListaMusica'
  ClientHeight = 468
  ClientWidth = 684
  Color = 2302755
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 137
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = 2302755
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object imgCapa: TImage
      Left = 0
      Top = 0
      Width = 137
      Height = 137
      Align = alLeft
    end
    object GridPanel1: TGridPanel
      Left = 137
      Top = 0
      Width = 547
      Height = 137
      Align = alClient
      BevelOuter = bvNone
      Caption = 'GridPanel1'
      Color = 2302755
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lblTitulo
          Row = 0
        end
        item
          Column = 0
          Control = lblSubtitulo
          Row = 1
        end
        item
          Column = 0
          Control = pnlBotoes
          Row = 2
        end>
      ParentBackground = False
      RowCollection = <
        item
          Value = 50.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 32.000000000000000000
        end
        item
          SizeStyle = ssAuto
        end>
      ShowCaption = False
      TabOrder = 0
      object lblTitulo: TbsSkinStdLabel
        Left = 0
        Top = 0
        Width = 547
        Height = 52
        EllipsType = bsetNone
        UseSkinFont = False
        UseSkinColor = False
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWhite
        DefaultFont.Height = 50
        DefaultFont.Name = 'Arial Narrow'
        DefaultFont.Style = []
        SkinDataName = 'stdlabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 40
        Font.Name = 'Tahoma'
        Font.Style = []
        Align = alClient
        Alignment = taCenter
        Caption = 'lblTitulo'
        ParentFont = False
        Layout = tlBottom
        WordWrap = True
        ExplicitWidth = 116
        ExplicitHeight = 40
      end
      object lblSubtitulo: TbsSkinStdLabel
        Left = 0
        Top = 52
        Width = 547
        Height = 52
        EllipsType = bsetNone
        UseSkinFont = False
        UseSkinColor = False
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWhite
        DefaultFont.Height = 50
        DefaultFont.Name = 'Arial Narrow'
        DefaultFont.Style = []
        SkinDataName = 'stdlabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 30
        Font.Name = 'Tahoma'
        Font.Style = []
        Align = alClient
        Alignment = taCenter
        Caption = 'lblSubtitulo'
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 124
        ExplicitHeight = 30
      end
      object pnlBotoes: TPanel
        Left = 0
        Top = 104
        Width = 547
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlBotoes'
        ShowCaption = False
        TabOrder = 0
        object lblDicaPB: TbsSkinStdLabel
          Left = 0
          Top = 0
          Width = 232
          Height = 32
          EllipsType = bsetNone
          UseSkinFont = False
          UseSkinColor = False
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWhite
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          SkinDataName = 'stdlabel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Align = alLeft
          Alignment = taLeftJustify
          Caption = 'Arquivos terminados em "-PB" s'#227'o tratados como playback'
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          Visible = False
        end
        object bsSkinSpeedButton6: TbsSkinSpeedButton
          AlignWithMargins = True
          Left = 416
          Top = 0
          Width = 121
          Height = 32
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          HintImageIndex = 0
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWhite
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = False
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 6
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = ' Reproduzir Todas'
          ShowCaption = True
          NumGlyphs = 1
          Align = alRight
          Margin = 5
          Spacing = 1
          OnClick = bsSkinSpeedButton6Click
          ExplicitLeft = 563
          ExplicitTop = 139
          ExplicitHeight = 331
        end
        object btExp_MenuMusicas: TbsSkinMenuSpeedButton
          Tag = 10
          AlignWithMargins = True
          Left = 232
          Top = 0
          Width = 174
          Height = 32
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWhite
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = False
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 53
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = ' Projetar Menu (Monitor 0)'
          ShowCaption = True
          NumGlyphs = 1
          Align = alRight
          Margin = 5
          Spacing = 1
          OnClick = btExp_MenuMusicasClick
          NewStyle = False
          TrackPosition = bstpRight
          UseImagesMenuImage = False
          UseImagesMenuCaption = False
          SkinPopupMenu = fmIndex.bsPopupExpand
          TrackButtonMode = True
          OnShowTrackMenu = btExp_MenuMusicasShowTrackMenu
        end
      end
    end
  end
  object DBCtrlGrid: TDBCtrlGrid
    Left = 0
    Top = 137
    Width = 684
    Height = 331
    Cursor = crHandPoint
    Align = alClient
    AllowDelete = False
    AllowInsert = False
    DataSource = DM.dsMUSICAS
    PanelBorder = gbNone
    PanelHeight = 66
    PanelWidth = 667
    TabOrder = 1
    RowCount = 5
    ShowFocus = False
    OnClick = DBCtrlGridClick
    OnPaintPanel = DBCtrlGridPaintPanel
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 667
      Height = 65
      Cursor = crHandPoint
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel2'
      Color = 3487029
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      OnClick = DBCtrlGridClick
      object GridPanel2: TGridPanel
        Left = 0
        Top = 0
        Width = 667
        Height = 65
        Cursor = crHandPoint
        Align = alClient
        BevelOuter = bvNone
        Caption = 'GridPanel2'
        Color = 2302755
        ColumnCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 50.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 30.000000000000000000
          end
          item
            Value = 100.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end>
        ControlCollection = <
          item
            Column = 1
            Control = bsSkinDBText1
            Row = 0
          end
          item
            Column = 0
            Control = ico
            Row = 0
          end
          item
            Column = 2
            Control = bsSkinDBText2
            Row = 0
          end
          item
            Column = 3
            Control = bsPngImageView1
            Row = 0
          end
          item
            Column = 4
            Control = btSlidePB
            Row = 0
          end
          item
            Column = 6
            Control = btMusica
            Row = 0
          end
          item
            Column = 7
            Control = btMusicaPB
            Row = 0
          end
          item
            Column = 8
            Control = btLetra
            Row = 0
          end
          item
            Column = 5
            Control = btSlideLetra
            Row = 0
          end>
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        RowCollection = <
          item
            Value = 100.000000000000000000
          end
          item
            SizeStyle = ssAuto
          end>
        ShowCaption = False
        TabOrder = 0
        OnClick = DBCtrlGridClick
        object bsSkinDBText1: TbsSkinDBText
          Left = 50
          Top = 0
          Width = 30
          Height = 65
          Cursor = crHandPoint
          EllipsType = bsetNone
          UseSkinFont = False
          UseSkinColor = False
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -11
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          SkinDataName = 'stdlabel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = 20
          Font.Name = 'Arial'
          Font.Style = []
          Align = alClient
          Alignment = taRightJustify
          Caption = 'bsSkinDBText1'
          Color = clBtnFace
          ParentColor = False
          ParentFont = False
          ShowAccelChar = False
          Layout = tlCenter
          WordWrap = True
          OnClick = DBCtrlGridClick
          DataField = 'FAIXA'
          DataSource = DM.dsMUSICAS
          Transparent = True
          ExplicitLeft = 13
          ExplicitTop = 12
          ExplicitWidth = 65
          ExplicitHeight = 17
        end
        object ico: TbsPngImageView
          Left = 0
          Top = 0
          Width = 50
          Height = 65
          Cursor = crHandPoint
          DoubleBuffered = False
          ReflectionEffect = False
          PngImageList = DM.ico_24x24
          ImageIndex = 74
          Align = alClient
          Center = True
          OnClick = DBCtrlGridClick
          ExplicitWidth = 24
          ExplicitHeight = 24
        end
        object bsSkinDBText2: TbsSkinDBText
          AlignWithMargins = True
          Left = 90
          Top = 0
          Width = 337
          Height = 65
          Cursor = crHandPoint
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          EllipsType = bsetNone
          UseSkinFont = False
          UseSkinColor = False
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -11
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          SkinDataName = 'stdlabel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = 20
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Align = alClient
          Caption = 'bsSkinDBText2'
          Color = clBtnFace
          ParentColor = False
          ParentFont = False
          ShowAccelChar = False
          Layout = tlCenter
          WordWrap = True
          OnClick = DBCtrlGridClick
          DataField = 'NOME'
          DataSource = DM.dsMUSICAS
          Transparent = True
          ExplicitLeft = 13
          ExplicitTop = 12
          ExplicitWidth = 65
          ExplicitHeight = 17
        end
        object bsPngImageView1: TbsPngImageView
          Tag = 1
          Left = 427
          Top = 0
          Width = 40
          Height = 65
          Cursor = crHandPoint
          Hint = 'Slide Cantado'
          DoubleBuffered = False
          ReflectionEffect = False
          AutoSize = False
          PngImageList = DM.ico_24x24
          ImageIndex = 76
          Align = alClient
          Center = True
          ShowHint = True
          OnClick = DBCtrlGridClick
          ExplicitLeft = 180
          ExplicitTop = 7
          ExplicitWidth = 50
          ExplicitHeight = 50
        end
        object btSlidePB: TbsPngImageView
          Tag = 2
          Left = 467
          Top = 0
          Width = 40
          Height = 65
          Cursor = crHandPoint
          Hint = 'Slide Playback'
          DoubleBuffered = False
          ReflectionEffect = False
          AutoSize = False
          PngImageList = DM.ico_24x24
          ImageIndex = 82
          Align = alClient
          Center = True
          ShowHint = True
          OnClick = DBCtrlGridClick
          ExplicitLeft = 204
          ExplicitTop = 7
          ExplicitWidth = 50
          ExplicitHeight = 50
        end
        object btMusica: TbsPngImageView
          Tag = 4
          Left = 547
          Top = 0
          Width = 40
          Height = 65
          Cursor = crHandPoint
          Hint = 'Arquivo Cantado'
          DoubleBuffered = False
          ReflectionEffect = False
          AutoSize = False
          PngImageList = DM.ico_24x24
          ImageIndex = 75
          Align = alClient
          Center = True
          ShowHint = True
          OnClick = DBCtrlGridClick
          ExplicitLeft = 252
          ExplicitTop = 7
          ExplicitWidth = 50
          ExplicitHeight = 50
        end
        object btMusicaPB: TbsPngImageView
          Tag = 5
          Left = 587
          Top = 0
          Width = 40
          Height = 65
          Cursor = crHandPoint
          Hint = 'Arquivo Playback'
          DoubleBuffered = False
          ReflectionEffect = False
          AutoSize = False
          PngImageList = DM.ico_24x24
          ImageIndex = 35
          Align = alClient
          Center = True
          ShowHint = True
          OnClick = DBCtrlGridClick
          ExplicitLeft = 267
          ExplicitTop = 2
          ExplicitWidth = 50
          ExplicitHeight = 50
        end
        object btLetra: TbsPngImageView
          Tag = 6
          Left = 627
          Top = 0
          Width = 40
          Height = 65
          Cursor = crHandPoint
          Hint = 'Letra da M'#250'sica'
          DoubleBuffered = False
          ReflectionEffect = False
          AutoSize = False
          PngImageList = DM.ico_24x24
          ImageIndex = 63
          Align = alClient
          Center = True
          ShowHint = True
          OnClick = DBCtrlGridClick
          ExplicitLeft = 284
          ExplicitTop = 2
          ExplicitWidth = 50
          ExplicitHeight = 50
        end
        object btSlideLetra: TbsPngImageView
          Tag = 3
          Left = 507
          Top = 0
          Width = 40
          Height = 65
          Cursor = crHandPoint
          Hint = 'Slide Sem '#193'udio'
          DoubleBuffered = False
          ReflectionEffect = False
          AutoSize = False
          PngImageList = DM.ico_24x24
          ImageIndex = 77
          Align = alClient
          Center = True
          ShowHint = True
          OnClick = DBCtrlGridClick
          ExplicitLeft = 228
          ExplicitTop = 7
          ExplicitWidth = 50
          ExplicitHeight = 50
        end
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 65
      Width = 667
      Height = 1
      Cursor = crHandPoint
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel3'
      Color = 5395026
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      ShowCaption = False
      TabOrder = 1
      OnClick = DBCtrlGridClick
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
    HideCaptionButtons = False
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
    BorderIcons = [biMaximize]
    Left = 111
    Top = 87
  end
end
