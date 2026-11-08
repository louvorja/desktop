object fBuscaMusica: TfBuscaMusica
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Busca de M'#250'sicas'
  ClientHeight = 296
  ClientWidth = 701
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  OnActivate = FormActivate
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object GridPanel3: TGridPanel
    Left = 0
    Top = 0
    Width = 701
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Caption = 'GridPanel2'
    ColumnCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 30.000000000000000000
      end
      item
        Value = 100.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 30.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 1
        Control = txtBusca
        Row = 1
      end
      item
        Column = 1
        Control = bsSkinStdLabel5
        Row = 0
      end
      item
        Column = 1
        Control = ckLetra
        Row = 2
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 19.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ShowCaption = False
    TabOrder = 0
    object txtBusca: TbsSkinEdit
      Left = 30
      Top = 19
      Width = 641
      Height = 19
      Text = ''
      DefaultColor = clWindow
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clBlack
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      UseSkinFont = True
      DefaultWidth = 0
      DefaultHeight = 0
      ButtonMode = False
      SkinData = DM.bsSkinData1
      SkinDataName = 'edit'
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ButtonImageIndex = -1
      LeftImageIndex = -1
      LeftImageHotIndex = -1
      LeftImageDownIndex = -1
      RightImageIndex = -1
      RightImageHotIndex = -1
      RightImageDownIndex = -1
      OnChange = txtBuscaChange
      OnKeyPress = txtBuscaKeyPress
      OnKeyUp = txtBuscaKeyUp
    end
    object bsSkinStdLabel5: TbsSkinStdLabel
      Left = 30
      Top = 0
      Width = 641
      Height = 19
      EllipsType = bsetNone
      UseSkinFont = True
      UseSkinColor = True
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      SkinData = DM.bsSkinData1
      SkinDataName = 'stdlabel'
      Align = alClient
      Caption = 'Localizar M'#250'sica:'
      Layout = tlCenter
      ExplicitWidth = 80
      ExplicitHeight = 13
    end
    object ckLetra: TbsSkinCheckBox
      Left = 30
      Top = 38
      Width = 641
      Height = 19
      HintImageIndex = 0
      TabOrder = 1
      SkinData = DM.bsSkinData1
      SkinDataName = 'checkbox'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      WordWrap = False
      AllowGrayed = False
      State = cbChecked
      ImageIndex = 0
      Flat = True
      UseSkinFontColor = True
      TabStop = True
      CanFocused = True
      Radio = False
      Checked = True
      GroupIndex = 0
      Caption = 'Buscar na letra da m'#250'sica'
      OnClick = ckLetraClick
      Align = alClient
    end
  end
  object DBGrid1: TbsSkinDBGrid
    Left = 0
    Top = 57
    Width = 682
    Height = 220
    HintImageIndex = 0
    TabOrder = 1
    SkinData = DM.bsSkinData1
    SkinDataName = 'grid'
    Transparent = False
    WallpaperStretch = False
    UseSkinFont = True
    UseSkinCellHeight = True
    VScrollBar = bsSkinScrollBar7
    GridLineColor = clBtnFace
    DefaultCellHeight = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ColSizingWithLine = False
    DrawGraphicFields = False
    UseColumnsFont = False
    MouseWheelSupport = True
    SaveMultiSelection = False
    PickListBoxSkinDataName = 'listbox'
    PickListBoxCaptionMode = False
    Align = alClient
    Ctl3D = False
    DataSource = dsBUSCA
    Options = [dgTitles, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'NOME_ALBUM_COM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Caption = #193'lbum'
        Width = 305
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ICONE1'
        Title.Caption = '  '
        Width = 20
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Title.Caption = 'M'#250'sica'
        Width = 367
        Visible = True
      end>
  end
  object stBusca: TbsSkinStatusBar
    Left = 0
    Top = 277
    Width = 701
    Height = 19
    HintImageIndex = 0
    TabOrder = 3
    SkinData = DM.bsSkinData1
    SkinDataName = 'statusbar'
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
    Align = alBottom
    SizeGrip = False
    object stBusca_0: TbsSkinStatusPanel
      Left = 0
      Top = 0
      Width = 320
      Height = 19
      HintImageIndex = 0
      TabOrder = 0
      SkinData = DM.bsSkinData1
      SkinDataName = 'statuspanel'
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
      BorderStyle = bvFrame
      Align = alClient
      AutoSize = False
      ImageIndex = -1
      NumGlyphs = 1
    end
    object stBusca_1: TbsSkinStatusPanel
      Left = 320
      Top = 0
      Width = 381
      Height = 19
      HintImageIndex = 0
      TabOrder = 1
      SkinData = DM.bsSkinData1
      SkinDataName = 'statuspanel'
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
      BorderStyle = bvFrame
      Align = alRight
      AutoSize = False
      ImageIndex = -1
      NumGlyphs = 1
    end
  end
  object bsSkinScrollBar7: TbsSkinScrollBar
    Left = 682
    Top = 57
    Width = 19
    Height = 220
    HintImageIndex = 0
    TabOrder = 2
    Visible = False
    SkinData = DM.bsSkinData1
    SkinDataName = 'vscrollbar'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 13
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    DefaultWidth = 19
    DefaultHeight = 0
    UseSkinFont = True
    Both = False
    BothMarkerWidth = 19
    BothSkinDataName = 'bothhscrollbar'
    CanFocused = False
    Align = alRight
    Kind = sbVertical
    PageSize = 0
    Min = 0
    Max = 0
    Position = 0
    SmallChange = 1
    LargeChange = 1
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
    Left = 167
    Top = 135
  end
  object qrBUSCA: TFDQuery
    Filtered = True
    Connection = DM.ADO
    SQL.Strings = (
      
        'SELECT DISTINCT '#39#39' AS ICONE1,'#39#39' AS ICONE2,'#39#39' AS ICONE3, M.ID ID,' +
        ' M.ID_ALBUM ID_ALBUM, M.NOME_ALBUM NOME_ALBUM, M.NOME_ALBUM_COM ' +
        'NOME_ALBUM_COM, M.FAIXA FAIXA, M.NOME NOME,'
      
        '    M.NOME_COM NOME_COM, M.TIPO_HASD TIPO_HASD, M.TIPO_JA TIPO_J' +
        'A, M.TIPO_BAIXADA TIPO_BAIXADA, M.TIPO_WEB TIPO_WEB, M.TIPO_PERS' +
        'O TIPO_PERSO, M.TIPO TIPO, M.URL_ALBUM URL_ALBUM,'
      
        '    M.ALBUM ALBUM, M.URL URL, M.URL_INSTRUMENTAL URL_INSTRUMENTA' +
        'L,'
      
        '    M.IDIOMA IDIOMA, M.LETRA LETRA, M.NOME_SEMAC NOME_SEMAC, M.N' +
        'OME_ALBUM_COM_SEMAC NOME_ALBUM_COM_SEMAC'
      'FROM LISTA_MUSICAS M'
      'WHERE'
      
        '    (CAST(:VALOR AS INTEGER) > 0 AND TIPO_HASD = '#39'S'#39' AND FAIXA =' +
        ' :VALOR)'
      '    OR'
      
        '    (CAST(:VALOR AS INTEGER) <= 0 AND NOME_SEMAC LIKE '#39'%'#39' || :VA' +
        'LOR || '#39'%'#39')'
      '    OR'
      '    (CAST(:VALOR AS INTEGER) <= 0 AND :OPC_LETRA = '#39'S'#39' AND LETRA_SEMAC LIKE '#39'%'#39' || :VALOR || '#39'%'#39')'
      '')
    Left = 354
    Top = 148
    ParamData = <
      item
        Name = 'VALOR'
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'OPC_LETRA'
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsBUSCA: TDataSource
    DataSet = qrBUSCA
    Left = 390
    Top = 148
  end
end
