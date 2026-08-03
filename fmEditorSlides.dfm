object fEditorSlides: TfEditorSlides
  Left = 0
  Top = 0
  ClientHeight = 431
  ClientWidth = 1263
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object bsRibbon1: TbsRibbon
    Left = 0
    Top = 0
    Width = 1263
    Height = 99
    HintImageIndex = 0
    TabOrder = 0
    SkinData = DM.bsSkinData1
    SkinDataName = 'officetab'
    Align = alTop
    Tabs = <
      item
        Page = bsArquivo
        Visible = True
      end
      item
        Page = bsRibbonPage2
        Visible = True
      end
      item
        Page = bsRibbonPage3
        Visible = True
      end
      item
        Page = bsRibbonPage4
        Visible = True
      end
      item
        Page = bsRibbonPage1
        Visible = True
      end>
    TabIndex = 0
    ActivePage = bsArquivo
    UseSkinFont = True
    AppButtonSpacing = 1
    AppButtonMargin = -1
    AppButtonWidth = 54
    AppButtonImageIndex = 0
    Buttons = <>
    ButtonsImageList = DM.ico_16x16
    ButtonsShowHint = False
    TabBoldStyle = False
    DesignSize = (
      1263
      99)
    object bsRibbonPage1: TbsRibbonPage
      Left = 1
      Top = 26
      Width = 1261
      Height = 70
      HotScroll = False
      ScrollOffset = 0
      ScrollTimerInterval = 50
      CanScroll = True
      Caption = 'Visualiza'#231#227'o'
      ExplicitWidth = 1076
      object bsRibbonGroup6: TbsRibbonGroup
        Left = 0
        Top = 0
        Width = 169
        Height = 70
        HintImageIndex = 0
        TabOrder = 0
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'Resolu'#231#227'o'
        ShowDialogButton = False
        object btRes169: TbsSkinSpeedButton
          Tag = 169
          Left = 117
          Top = 2
          Width = 50
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = True
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 104
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = -1
          Caption = '16:9'
          ShowCaption = True
          NumGlyphs = 1
          Align = alRight
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btRes0Click
          ExplicitLeft = 189
        end
        object btRes0: TbsSkinSpeedButton
          Left = 2
          Top = 2
          Width = 65
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = True
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 102
          RepeatMode = False
          RepeatInterval = 100
          Transparent = False
          Flat = True
          AllowAllUp = False
          Down = True
          GroupIndex = -1
          Caption = 'Tela Cheia'
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btRes0Click
          ExplicitLeft = -4
        end
        object btRes43: TbsSkinSpeedButton
          Tag = 43
          Left = 67
          Top = 2
          Width = 50
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = True
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 103
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = -1
          Caption = '4:3'
          ShowCaption = True
          NumGlyphs = 1
          Align = alRight
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btRes0Click
          ExplicitLeft = 139
        end
      end
    end
    object bsRibbonPage4: TbsRibbonPage
      Left = 1
      Top = 26
      Width = 1261
      Height = 70
      HotScroll = False
      ScrollOffset = 0
      ScrollTimerInterval = 50
      CanScroll = True
      Caption = 'Formatar'
      ExplicitWidth = 1076
      ExplicitHeight = 68
      object bsRibbonGroup8: TbsRibbonGroup
        Left = 532
        Top = 0
        Width = 130
        Height = 70
        HintImageIndex = 0
        TabOrder = 2
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'Texto Principal'
        ShowDialogButton = False
        object GridPanel1: TGridPanel
          Left = 2
          Top = 2
          Width = 126
          Height = 49
          Align = alClient
          BevelOuter = bvNone
          Caption = 'GridPanel1'
          ColumnCollection = <
            item
              Value = 50.000000000000000000
            end
            item
              Value = 50.000000000000000000
            end>
          ControlCollection = <
            item
              Column = 1
              Control = tamanhoLetra
              Row = 0
            end
            item
              Column = 1
              Control = corLetra
              Row = 1
            end
            item
              Column = 0
              Control = bsSkinStdLabel1
              Row = 0
            end
            item
              Column = 0
              Control = bsSkinStdLabel2
              Row = 1
            end>
          RowCollection = <
            item
              Value = 50.000000000000000000
            end
            item
              Value = 50.000000000000000000
            end>
          ShowCaption = False
          TabOrder = 0
          object tamanhoLetra: TbsSkinSpinEdit
            Tag = 9999
            AlignWithMargins = True
            Left = 63
            Top = 2
            Width = 63
            Height = 21
            Margins.Left = 0
            Margins.Top = 2
            Margins.Right = 0
            Margins.Bottom = 1
            HintImageIndex = 0
            TabOrder = 0
            SkinData = DM.bsSkinData1
            SkinDataName = 'spinedit'
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 13
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = True
            DefaultColor = clWindow
            UseSkinSize = True
            ValueType = vtInteger
            Align = alClient
            Increment = 1.000000000000000000
            EditorEnabled = True
            MaxLength = 0
            OnChange = tamanhoLetraChange
          end
          object corLetra: TbsSkinColorButton
            AlignWithMargins = True
            Left = 63
            Top = 25
            Width = 63
            Height = 21
            Hint = 'Cor da Fonte'
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 0
            HintImageIndex = 0
            SkinData = DM.bsSkinData1
            SkinDataName = 'toolmenubutton'
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 13
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = True
            CheckedMode = False
            ImageList = DM.ico_16x16
            UseSkinSize = False
            UseSkinFontColor = True
            WidthWithCaption = 0
            WidthWithoutCaption = 0
            ImageIndex = 50
            RepeatMode = False
            RepeatInterval = 100
            Transparent = False
            Flat = False
            AllowAllUp = False
            ShowHint = False
            ParentShowHint = False
            Down = False
            GroupIndex = 0
            ShowCaption = True
            NumGlyphs = 1
            Align = alClient
            Spacing = 1
            NewStyle = False
            TrackPosition = bstpRight
            UseImagesMenuImage = False
            UseImagesMenuCaption = False
            TrackButtonMode = False
            AutoColor = clBlack
            ColorValue = clBlack
            ShowAutoColor = True
            ShowMoreColor = True
            MenuUseSkinFont = True
            MenuDefaultFont.Charset = DEFAULT_CHARSET
            MenuDefaultFont.Color = clWindowText
            MenuDefaultFont.Height = 13
            MenuDefaultFont.Name = 'Tahoma'
            MenuDefaultFont.Style = []
            MenuAlphaBlend = False
            MenuAlphaBlendValue = 200
            MenuAlphaBlendAnimation = False
            OnChangeColor = corLetraChangeColor
            ExplicitLeft = 64
            ExplicitTop = 24
            ExplicitHeight = 22
          end
          object bsSkinStdLabel1: TbsSkinStdLabel
            Left = 0
            Top = 0
            Width = 63
            Height = 24
            EllipsType = bsetNone
            UseSkinFont = True
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 13
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            SkinData = DM.bsSkinData1
            SkinDataName = 'stdlabel'
            Align = alClient
            AutoSize = False
            Caption = 'Tamanho:'
            Layout = tlCenter
            ExplicitLeft = 8
            ExplicitTop = 8
            ExplicitHeight = 23
          end
          object bsSkinStdLabel2: TbsSkinStdLabel
            Left = 0
            Top = 24
            Width = 63
            Height = 25
            EllipsType = bsetNone
            UseSkinFont = True
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 13
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            SkinData = DM.bsSkinData1
            SkinDataName = 'stdlabel'
            Align = alClient
            AutoSize = False
            Caption = 'Cor:'
            Layout = tlCenter
            ExplicitLeft = 8
            ExplicitTop = 23
            ExplicitHeight = 24
          end
        end
      end
      object bsRibbonGroup9: TbsRibbonGroup
        Left = 0
        Top = 0
        Width = 295
        Height = 70
        HintImageIndex = 0
        TabOrder = 0
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'Fundo'
        ShowDialogButton = False
        object bsSkinSpeedButton6: TbsSkinSpeedButton
          Tag = 1
          Left = 2
          Top = 2
          Width = 49
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 105
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Imagem'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = bsSkinSpeedButton6Click
        end
        object btRemoveImagem: TbsSkinSpeedButton
          Tag = 1
          Left = 51
          Top = 2
          Width = 98
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 106
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Remover Imagem'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btRemoveImagemClick
        end
        object GridPanel4: TGridPanel
          Left = 149
          Top = 2
          Width = 144
          Height = 49
          Align = alClient
          BevelOuter = bvNone
          Caption = 'GridPanel1'
          ColumnCollection = <
            item
              SizeStyle = ssAbsolute
              Value = 50.000000000000000000
            end
            item
              Value = 100.000000000000000000
            end>
          ControlCollection = <
            item
              Column = 0
              Control = bsSkinStdLabel8
              Row = 1
            end
            item
              Column = 1
              Control = posicaoFundo
              Row = 1
            end
            item
              Column = 0
              Control = bsSkinStdLabel9
              Row = 3
            end
            item
              Column = 1
              Control = corFundo
              Row = 3
            end>
          RowCollection = <
            item
              Value = 33.500835743511700000
            end
            item
              SizeStyle = ssAbsolute
              Value = 20.000000000000000000
            end
            item
              Value = 33.333056212927030000
            end
            item
              SizeStyle = ssAbsolute
              Value = 20.000000000000000000
            end
            item
              Value = 33.166108043561270000
            end>
          ShowCaption = False
          TabOrder = 0
          DesignSize = (
            144
            49)
          object bsSkinStdLabel8: TbsSkinStdLabel
            Left = 0
            Top = 3
            Width = 50
            Height = 20
            EllipsType = bsetNone
            UseSkinFont = True
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 13
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            SkinData = DM.bsSkinData1
            SkinDataName = 'stdlabel'
            Align = alClient
            AutoSize = False
            Caption = 'Posi'#231#227'o:'
            Layout = tlCenter
            ExplicitLeft = 8
            ExplicitTop = 23
            ExplicitWidth = 63
            ExplicitHeight = 24
          end
          object posicaoFundo: TbsSkinComboBoxEx
            Tag = 9999
            Left = 50
            Top = 3
            Width = 94
            Height = 20
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 0
            HintImageIndex = 0
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 0
            SkinData = DM.bsSkinData1
            SkinDataName = 'combobox'
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 13
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = True
            UseSkinSize = False
            ToolButtonStyle = False
            ItemsEx = <
              item
                Caption = 'Topo Esq.'
                ImageIndex = 92
                SelectedImageIndex = 92
              end
              item
                Caption = 'Topo'
                ImageIndex = 93
                SelectedImageIndex = 93
              end
              item
                Caption = 'Topo Dir.'
                ImageIndex = 94
                SelectedImageIndex = 94
              end
              item
                Caption = 'Centro Esq.'
                ImageIndex = 95
                SelectedImageIndex = 95
              end
              item
                Caption = 'Centro'
                ImageIndex = 96
                SelectedImageIndex = 96
              end
              item
                Caption = 'Centro Dir.'
                ImageIndex = 97
                SelectedImageIndex = 97
              end
              item
                Caption = 'Rodap'#233' Esq.'
                ImageIndex = 98
                SelectedImageIndex = 98
              end
              item
                Caption = 'Rodap'#233
                ImageIndex = 99
                SelectedImageIndex = 99
              end
              item
                Caption = 'Rodap'#233' Dir.'
                ImageIndex = 100
                SelectedImageIndex = 100
              end>
            Style = bscbFixedStyle
            HideSelection = True
            AutoComplete = True
            ListBoxUseSkinFont = True
            ListBoxUseSkinItemHeight = True
            ListBoxWidth = 0
            Images = DM.ico_16x16
            AlphaBlend = False
            AlphaBlendValue = 0
            AlphaBlendAnimation = False
            ListBoxCaptionMode = False
            ListBoxDefaultFont.Charset = DEFAULT_CHARSET
            ListBoxDefaultFont.Color = clWindowText
            ListBoxDefaultFont.Height = 13
            ListBoxDefaultFont.Name = 'Tahoma'
            ListBoxDefaultFont.Style = []
            ListBoxDefaultCaptionFont.Charset = DEFAULT_CHARSET
            ListBoxDefaultCaptionFont.Color = clWindowText
            ListBoxDefaultCaptionFont.Height = 13
            ListBoxDefaultCaptionFont.Name = 'Tahoma'
            ListBoxDefaultCaptionFont.Style = []
            ListBoxDefaultItemHeight = 20
            ListBoxCaptionAlignment = taLeftJustify
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = 13
            Font.Name = 'Tahoma'
            Font.Style = []
            OnClick = posicaoFundoClick
          end
          object bsSkinStdLabel9: TbsSkinStdLabel
            Left = 0
            Top = 25
            Width = 50
            Height = 20
            Margins.Left = 5
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            EllipsType = bsetNone
            UseSkinFont = True
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 13
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            SkinData = DM.bsSkinData1
            SkinDataName = 'stdlabel'
            Align = alClient
            AutoSize = False
            Caption = ' Cor:'
            Layout = tlCenter
            ExplicitLeft = 8
            ExplicitTop = 28
            ExplicitWidth = 3
            ExplicitHeight = 13
          end
          object corFundo: TbsSkinColorButton
            Tag = 19
            Left = 50
            Top = 25
            Width = 94
            Height = 20
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 0
            HintImageIndex = 0
            SkinData = DM.bsSkinData1
            SkinDataName = 'toolmenubutton'
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 13
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = True
            CheckedMode = False
            UseSkinSize = False
            UseSkinFontColor = True
            WidthWithCaption = 0
            WidthWithoutCaption = 0
            ImageIndex = 0
            RepeatMode = False
            RepeatInterval = 100
            Transparent = False
            Flat = False
            AllowAllUp = False
            Down = False
            GroupIndex = 0
            ShowCaption = True
            NumGlyphs = 1
            Align = alClient
            Spacing = 1
            NewStyle = False
            TrackPosition = bstpRight
            UseImagesMenuImage = False
            UseImagesMenuCaption = False
            TrackButtonMode = False
            AutoColor = clBlack
            ColorValue = clBlack
            ShowAutoColor = True
            ShowMoreColor = True
            MenuUseSkinFont = True
            MenuDefaultFont.Charset = DEFAULT_CHARSET
            MenuDefaultFont.Color = clWindowText
            MenuDefaultFont.Height = 13
            MenuDefaultFont.Name = 'Tahoma'
            MenuDefaultFont.Style = []
            MenuAlphaBlend = False
            MenuAlphaBlendValue = 200
            MenuAlphaBlendAnimation = False
            OnChangeColor = corFundoChangeColor
            ExplicitLeft = 205
            ExplicitWidth = 50
            ExplicitHeight = 21
          end
        end
      end
      object bsRibbonGroup12: TbsRibbonGroup
        Left = 662
        Top = 0
        Width = 130
        Height = 70
        HintImageIndex = 0
        TabOrder = 3
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'Texto Auxiliar'
        ShowDialogButton = False
        object GridPanel3: TGridPanel
          Left = 2
          Top = 2
          Width = 126
          Height = 49
          Align = alClient
          BevelOuter = bvNone
          Caption = 'GridPanel1'
          ColumnCollection = <
            item
              Value = 50.000000000000000000
            end
            item
              Value = 50.000000000000000000
            end>
          ControlCollection = <
            item
              Column = 1
              Control = tamanhoLetra_aux
              Row = 0
            end
            item
              Column = 0
              Control = bsSkinStdLabel3
              Row = 0
            end
            item
              Column = 0
              Control = bsSkinStdLabel4
              Row = 1
            end
            item
              Column = 1
              Control = corLetra_aux
              Row = 1
            end>
          RowCollection = <
            item
              Value = 50.000000000000000000
            end
            item
              Value = 50.000000000000000000
            end>
          ShowCaption = False
          TabOrder = 0
          object tamanhoLetra_aux: TbsSkinSpinEdit
            Tag = 9999
            AlignWithMargins = True
            Left = 63
            Top = 2
            Width = 63
            Height = 21
            Margins.Left = 0
            Margins.Top = 2
            Margins.Right = 0
            Margins.Bottom = 1
            HintImageIndex = 0
            TabOrder = 0
            SkinData = DM.bsSkinData1
            SkinDataName = 'spinedit'
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 13
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = True
            DefaultColor = clWindow
            UseSkinSize = True
            ValueType = vtInteger
            Align = alClient
            Increment = 1.000000000000000000
            EditorEnabled = True
            MaxLength = 0
            OnChange = tamanhoLetra_auxChange
          end
          object bsSkinStdLabel3: TbsSkinStdLabel
            Left = 0
            Top = 0
            Width = 63
            Height = 24
            EllipsType = bsetNone
            UseSkinFont = True
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 13
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            SkinData = DM.bsSkinData1
            SkinDataName = 'stdlabel'
            Align = alClient
            AutoSize = False
            Caption = 'Tamanho:'
            Layout = tlCenter
            ExplicitHeight = 23
          end
          object bsSkinStdLabel4: TbsSkinStdLabel
            Left = 0
            Top = 24
            Width = 63
            Height = 25
            EllipsType = bsetNone
            UseSkinFont = True
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 13
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            SkinData = DM.bsSkinData1
            SkinDataName = 'stdlabel'
            Align = alClient
            AutoSize = False
            Caption = 'Cor:'
            Layout = tlCenter
            ExplicitTop = 23
            ExplicitHeight = 24
          end
          object corLetra_aux: TbsSkinColorButton
            AlignWithMargins = True
            Left = 63
            Top = 25
            Width = 63
            Height = 21
            Hint = 'Cor da Fonte'
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 0
            HintImageIndex = 0
            SkinData = DM.bsSkinData1
            SkinDataName = 'toolmenubutton'
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 13
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = True
            CheckedMode = False
            ImageList = DM.ico_16x16
            UseSkinSize = False
            UseSkinFontColor = True
            WidthWithCaption = 0
            WidthWithoutCaption = 0
            ImageIndex = 50
            RepeatMode = False
            RepeatInterval = 100
            Transparent = False
            Flat = False
            AllowAllUp = False
            ShowHint = False
            ParentShowHint = False
            Down = False
            GroupIndex = 0
            ShowCaption = True
            NumGlyphs = 1
            Align = alClient
            Spacing = 1
            NewStyle = False
            TrackPosition = bstpRight
            UseImagesMenuImage = False
            UseImagesMenuCaption = False
            TrackButtonMode = False
            AutoColor = clBlack
            ColorValue = clBlack
            ShowAutoColor = True
            ShowMoreColor = True
            MenuUseSkinFont = True
            MenuDefaultFont.Charset = DEFAULT_CHARSET
            MenuDefaultFont.Color = clWindowText
            MenuDefaultFont.Height = 13
            MenuDefaultFont.Name = 'Tahoma'
            MenuDefaultFont.Style = []
            MenuAlphaBlend = False
            MenuAlphaBlendValue = 200
            MenuAlphaBlendAnimation = False
            OnChangeColor = corLetra_auxChangeColor
            ExplicitLeft = 6
            ExplicitTop = 31
            ExplicitWidth = 25
            ExplicitHeight = 24
          end
        end
      end
      object bsRibbonGroup13: TbsRibbonGroup
        Left = 295
        Top = 0
        Width = 237
        Height = 70
        HintImageIndex = 0
        TabOrder = 1
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'Replicar Fundo'
        ShowDialogButton = False
        object bsSkinSpeedButton2: TbsSkinSpeedButton
          Tag = 3
          Left = 164
          Top = 2
          Width = 71
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 87
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Todos Slides'
          ShowCaption = True
          NumGlyphs = 1
          Align = alRight
          Spacing = 1
          Layout = blGlyphTop
          OnClick = replicaFormatacaoFundo
          ExplicitLeft = 2
          ExplicitHeight = 47
        end
        object bsSkinSpeedButton8: TbsSkinSpeedButton
          Tag = 1
          Left = 2
          Top = 2
          Width = 77
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 85
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Slide Seguinte'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = replicaFormatacaoFundo
        end
        object bsSkinSpeedButton10: TbsSkinSpeedButton
          Tag = 2
          Left = 79
          Top = 2
          Width = 85
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 86
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Todos Seguintes'
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          Layout = blGlyphTop
          OnClick = replicaFormatacaoFundo
          ExplicitLeft = 73
          ExplicitWidth = 80
          ExplicitHeight = 47
        end
      end
      object bsRibbonGroup14: TbsRibbonGroup
        Left = 922
        Top = 0
        Width = 237
        Height = 70
        HintImageIndex = 0
        TabOrder = 5
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'Replicar Formata'#231#227'o de Texto'
        ShowDialogButton = False
        object bsSkinSpeedButton17: TbsSkinSpeedButton
          Tag = 3
          Left = 164
          Top = 2
          Width = 71
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 90
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Todos Slides'
          ShowCaption = True
          NumGlyphs = 1
          Align = alRight
          Spacing = 1
          Layout = blGlyphTop
          OnClick = replicaFormatacaoTexto
          ExplicitLeft = 2
          ExplicitHeight = 47
        end
        object bsSkinSpeedButton18: TbsSkinSpeedButton
          Tag = 1
          Left = 2
          Top = 2
          Width = 77
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 88
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Slide Seguinte'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = replicaFormatacaoTexto
        end
        object bsSkinSpeedButton23: TbsSkinSpeedButton
          Tag = 2
          Left = 79
          Top = 2
          Width = 85
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 89
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Todos Seguintes'
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          Layout = blGlyphTop
          OnClick = replicaFormatacaoTexto
          ExplicitLeft = 73
          ExplicitWidth = 80
          ExplicitHeight = 47
        end
      end
      object bsRibbonGroup15: TbsRibbonGroup
        Left = 792
        Top = 0
        Width = 130
        Height = 70
        HintImageIndex = 0
        TabOrder = 4
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'Op'#231#245'es de Texto'
        ShowDialogButton = False
        object fundoTransparente: TbsSkinCheckBox
          Left = 2
          Top = 2
          Width = 126
          Height = 49
          HintImageIndex = 0
          TabOrder = 0
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
          State = cbUnchecked
          ImageIndex = 0
          Flat = True
          UseSkinFontColor = True
          TabStop = True
          CanFocused = True
          Radio = False
          Checked = False
          GroupIndex = 0
          Caption = 'Fundo Transparente'
          OnClick = fundoTransparenteClick
          Align = alClient
        end
      end
    end
    object bsRibbonPage2: TbsRibbonPage
      Left = 1
      Top = 26
      Width = 1261
      Height = 70
      HotScroll = False
      ScrollOffset = 0
      ScrollTimerInterval = 50
      CanScroll = True
      Caption = 'Slides'
      ExplicitWidth = 1076
      ExplicitHeight = 68
      object bsRibbonGroup3: TbsRibbonGroup
        Left = 530
        Top = 0
        Width = 179
        Height = 70
        HintImageIndex = 0
        TabOrder = 2
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'Controles de Slides'
        ShowDialogButton = False
        object bsSkinSpeedButton9: TbsSkinSpeedButton
          Left = 97
          Top = 2
          Width = 40
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 21
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          OnClick = bsSkinSpeedButton3Click
          ExplicitHeight = 47
        end
        object bsSkinSpeedButton11: TbsSkinSpeedButton
          Left = 42
          Top = 2
          Width = 40
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 22
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          OnClick = bsSkinSpeedButton1Click
          ExplicitHeight = 47
        end
        object bsRibbonDivider4: TbsRibbonDivider
          Left = 82
          Top = 2
          Width = 15
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'officegroupdivider'
          DividerType = bsdtVerticalLine
          Align = alLeft
          ExplicitLeft = 49
          ExplicitHeight = 50
        end
        object bsSkinSpeedButton12: TbsSkinSpeedButton
          Left = 137
          Top = 2
          Width = 40
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 78
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          OnClick = bsSkinSpeedButton4Click
          ExplicitHeight = 47
        end
        object bsSkinSpeedButton13: TbsSkinSpeedButton
          Left = 2
          Top = 2
          Width = 40
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 79
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          OnClick = bsSkinSpeedButton5Click
          ExplicitHeight = 47
        end
      end
      object bsRibbonGroup4: TbsRibbonGroup
        Left = 97
        Top = 0
        Width = 433
        Height = 70
        HintImageIndex = 0
        TabOrder = 1
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'A'#231#245'es'
        ShowDialogButton = False
        object btNovoSlide: TbsSkinSpeedButton
          Tag = 1
          Left = 2
          Top = 2
          Width = 80
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 91
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Novo Slide'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btNovoSlideClick
          ExplicitHeight = 47
        end
        object btExcluiSlide: TbsSkinSpeedButton
          Left = 162
          Top = 2
          Width = 80
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 92
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Excluir Slide'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btExcluiSlideClick
          ExplicitHeight = 47
        end
        object btDuplicaSlide: TbsSkinSpeedButton
          Tag = 2
          Left = 82
          Top = 2
          Width = 80
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 93
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Duplicar Slide'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btNovoSlideClick
          ExplicitHeight = 47
        end
        object bsRibbonDivider2: TbsRibbonDivider
          Left = 242
          Top = 2
          Width = 15
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'officegroupdivider'
          DividerType = bsdtVerticalLine
          Align = alLeft
          ExplicitLeft = 233
          ExplicitTop = 0
          ExplicitHeight = 47
        end
        object btDivideSlide: TbsSkinSpeedButton
          Left = 257
          Top = 2
          Width = 80
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 94
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Dividir Slide'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btDivideSlideClick
          ExplicitLeft = 362
          ExplicitHeight = 47
        end
        object btMesclaSlide: TbsSkinSpeedButton
          Left = 337
          Top = 2
          Width = 94
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 95
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Mesclar Pr'#243'x. Slide'
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btMesclaSlideClick
          ExplicitWidth = 95
          ExplicitHeight = 47
        end
      end
      object bsRibbonGroup5: TbsRibbonGroup
        Left = 0
        Top = 0
        Width = 97
        Height = 70
        HintImageIndex = 0
        TabOrder = 0
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'Projetar Slides'
        ShowDialogButton = False
        object btProjeta: TbsSkinSpeedButton
          Left = 2
          Top = 2
          Width = 93
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
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
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          OnClick = btProjetaClick
          ExplicitWidth = 40
          ExplicitHeight = 47
        end
      end
    end
    object bsRibbonPage3: TbsRibbonPage
      Left = 1
      Top = 26
      Width = 1261
      Height = 70
      HotScroll = False
      ScrollOffset = 0
      ScrollTimerInterval = 50
      CanScroll = True
      Caption = #193'udio/Grava'#231#227'o'
      ExplicitWidth = 766
      ExplicitHeight = 86
      object bsRibbonGroup7: TbsRibbonGroup
        Left = 133
        Top = 0
        Width = 480
        Height = 70
        HintImageIndex = 0
        TabOrder = 1
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'Grava'#231#227'o'
        ShowDialogButton = False
        object btGravaA: TbsSkinSpeedButton
          Left = 72
          Top = 2
          Width = 97
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 98
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Gravar e Avan'#231'ar'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btGravaAClick
          ExplicitLeft = 88
          ExplicitHeight = 47
        end
        object btGravaR: TbsSkinSpeedButton
          Left = 249
          Top = 2
          Width = 103
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 100
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Gravar Retroativo'
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btGravaRClick
          ExplicitLeft = 265
          ExplicitWidth = 104
          ExplicitHeight = 47
        end
        object btPausePlay2: TbsSkinSpeedButton
          Left = 2
          Top = 2
          Width = 55
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 8
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Reproduzir'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btPausePlayClick
          ExplicitHeight = 47
        end
        object bsRibbonDivider5: TbsRibbonDivider
          Left = 57
          Top = 2
          Width = 15
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'officegroupdivider'
          DividerType = bsdtVerticalLine
          Align = alLeft
          ExplicitLeft = 114
          ExplicitTop = 3
          ExplicitHeight = 47
        end
        object btGravaI: TbsSkinSpeedButton
          Left = 184
          Top = 2
          Width = 65
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 99
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Gravar In'#237'cio'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btGravaIClick
          ExplicitLeft = 160
          ExplicitHeight = 47
        end
        object bsRibbonDivider6: TbsRibbonDivider
          Left = 169
          Top = 2
          Width = 15
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'officegroupdivider'
          DividerType = bsdtVerticalLine
          Align = alLeft
          ExplicitLeft = 230
          ExplicitTop = 0
          ExplicitHeight = 47
        end
        object bsRibbonDivider7: TbsRibbonDivider
          Left = 352
          Top = 2
          Width = 15
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'officegroupdivider'
          DividerType = bsdtVerticalLine
          Align = alRight
          ExplicitLeft = 351
          ExplicitHeight = 47
        end
        object btRemoveGr: TbsSkinSpeedButton
          Left = 367
          Top = 2
          Width = 111
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 101
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Remover grava'#231#245'es'
          ShowCaption = True
          NumGlyphs = 1
          Align = alRight
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btRemoveGrClick
          ExplicitLeft = 335
          ExplicitHeight = 47
        end
      end
      object bsRibbonGroup2: TbsRibbonGroup
        Left = 0
        Top = 0
        Width = 133
        Height = 70
        HintImageIndex = 0
        TabOrder = 0
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'Arquivo de '#193'udio'
        ShowDialogButton = False
        object btAudio: TbsSkinSpeedButton
          Tag = 1
          Left = 2
          Top = 2
          Width = 39
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 60
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = #193'udio'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btAudioClick
        end
        object btRemoveAudio: TbsSkinSpeedButton
          Tag = 1
          Left = 41
          Top = 2
          Width = 90
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 107
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Remover '#193'udio'
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btRemoveAudioClick
          ExplicitLeft = 47
          ExplicitTop = 3
        end
      end
    end
    object bsArquivo: TbsRibbonPage
      Left = 1
      Top = 26
      Width = 1261
      Height = 70
      HotScroll = False
      ScrollOffset = 0
      ScrollTimerInterval = 50
      CanScroll = True
      Caption = 'Arquivo'
      ExplicitWidth = 766
      ExplicitHeight = 86
      object bsRibbonGroup1: TbsRibbonGroup
        Left = 0
        Top = 0
        Width = 344
        Height = 70
        HintImageIndex = 0
        TabOrder = 0
        SkinData = DM.bsSkinData1
        SkinDataName = 'officegroup'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Align = alLeft
        Caption = 'A'#231#245'es'
        ShowDialogButton = False
        object btSalvar: TbsSkinSpeedButton
          Left = 137
          Top = 2
          Width = 60
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 2
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Salvar'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btSalvarClick
          ExplicitHeight = 47
        end
        object btAbrir: TbsSkinSpeedButton
          Left = 62
          Top = 2
          Width = 60
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 32
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Abrir'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btAbrirClick
          ExplicitHeight = 47
        end
        object bsRibbonDivider1: TbsRibbonDivider
          Left = 122
          Top = 2
          Width = 15
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'officegroupdivider'
          DividerType = bsdtVerticalLine
          Align = alLeft
          ExplicitLeft = 49
          ExplicitHeight = 50
        end
        object btSalvarComo: TbsSkinSpeedButton
          Left = 197
          Top = 2
          Width = 70
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 84
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Salvar como'
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btSalvarComoClick
          ExplicitLeft = 177
          ExplicitWidth = 112
          ExplicitHeight = 31
        end
        object btNovo: TbsSkinSpeedButton
          Left = 2
          Top = 2
          Width = 60
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 67
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Novo'
          ShowCaption = True
          NumGlyphs = 1
          Align = alLeft
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btNovoClick
          ExplicitHeight = 47
        end
        object bsRibbonDivider3: TbsRibbonDivider
          Left = 267
          Top = 2
          Width = 15
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'officegroupdivider'
          DividerType = bsdtVerticalLine
          Align = alRight
          ExplicitLeft = 49
          ExplicitHeight = 50
        end
        object brImportar: TbsSkinSpeedButton
          Left = 282
          Top = 2
          Width = 60
          Height = 49
          HintImageIndex = 0
          SkinData = DM.bsSkinData1
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 97
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          Caption = 'Importar'
          ShowCaption = True
          NumGlyphs = 1
          Align = alRight
          Spacing = 1
          Layout = blGlyphTop
          OnClick = brImportarClick
          ExplicitLeft = 344
          ExplicitHeight = 47
        end
      end
    end
  end
  object param: TValueListEditor
    Left = 0
    Top = 99
    Width = 259
    Height = 213
    Align = alLeft
    TabOrder = 1
    Visible = False
    ColWidths = (
      150
      103)
  end
  object dbGrid: TbsSkinDBGrid
    Left = 0
    Top = 312
    Width = 1263
    Height = 119
    HintImageIndex = 0
    TabOrder = 5
    Visible = False
    SkinDataName = 'grid'
    Transparent = False
    WallpaperStretch = False
    TabStop = False
    UseSkinFont = True
    UseSkinCellHeight = True
    GridLineColor = clBtnFace
    DefaultCellHeight = 20
    ColSizingWithLine = False
    DrawGraphicFields = False
    UseColumnsFont = False
    DefaultRowHeight = 17
    MouseWheelSupport = True
    SaveMultiSelection = False
    PickListBoxSkinDataName = 'listbox'
    PickListBoxCaptionMode = False
    Align = alBottom
    DataSource = DM.dsSLIDE_MUSICA2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = dbGridDrawColumnCell
  end
  object Panel2: TPanel
    Left = 259
    Top = 99
    Width = 300
    Height = 213
    Align = alLeft
    BevelOuter = bvNone
    Color = 3487029
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    object DBGrid1: TbsSkinDBGrid
      Left = 0
      Top = 129
      Width = 281
      Height = 84
      HintImageIndex = 0
      TabOrder = 3
      SkinDataName = 'grid'
      Transparent = False
      WallpaperStretch = False
      UseSkinFont = False
      UseSkinCellHeight = False
      VScrollBar = bsSkinScrollBar7
      GridLineColor = 5395026
      DefaultCellHeight = 60
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'DIN Condensed'
      Font.Style = []
      ColSizingWithLine = False
      DrawGraphicFields = False
      UseColumnsFont = False
      DefaultRowHeight = 60
      MouseWheelSupport = True
      SaveMultiSelection = False
      PickListBoxSkinDataName = 'listbox'
      PickListBoxCaptionMode = False
      Align = alClient
      Color = 3487029
      Ctl3D = False
      DataSource = DM.dsSLIDE_MUSICA2
      Options = [dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ParentFont = False
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnCellClick = DBGrid1CellClick
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnKeyDown = DBGrid1KeyDown
      OnKeyPress = DBGrid1KeyPress
      OnKeyUp = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LETRA_UCASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = 22
          Font.Name = 'DIN Condensed'
          Font.Style = []
          Width = 236
          Visible = True
        end
        item
          Expanded = False
          Width = 40
          Visible = True
        end>
    end
    object bsSkinScrollBar7: TbsSkinScrollBar
      Left = 281
      Top = 129
      Width = 19
      Height = 84
      HintImageIndex = 0
      TabOrder = 4
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
    object Panel4: TbsSkinPanel
      Left = 0
      Top = 60
      Width = 300
      Height = 50
      HintImageIndex = 0
      TabOrder = 1
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
      Caption = 'Panel4'
      Align = alTop
      object bsSkinStdLabel6: TbsSkinLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 294
        Height = 13
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
        Transparent = True
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
        Align = alTop
        Caption = 'Texto Auxiliar:'
        AutoSize = True
      end
      object bsSkinScrollBar1: TbsSkinScrollBar
        Left = 281
        Top = 19
        Width = 19
        Height = 31
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
        PageSize = 1
        Min = 0
        Max = 1
        Position = 0
        SmallChange = 1
        LargeChange = 1
      end
      object textoLetraAux: TbsSkinMemo
        Tag = 9999
        Left = 0
        Top = 19
        Width = 281
        Height = 31
        Align = alClient
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 13
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          'bsSkinMemo3')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
        OnChange = textoLetraAuxChange
        Transparent = False
        WallpaperStretch = False
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clBlack
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        UseSkinFont = True
        UseSkinFontColor = True
        BitMapBG = True
        VScrollBar = bsSkinScrollBar1
        SkinData = DM.bsSkinData1
        SkinDataName = 'memo'
      end
    end
    object Panel5: TbsSkinPanel
      Left = 0
      Top = 0
      Width = 300
      Height = 60
      HintImageIndex = 0
      TabOrder = 0
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
      Caption = 'Panel4'
      Align = alTop
      object bsSkinStdLabel5: TbsSkinLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 294
        Height = 13
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
        Transparent = True
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
        Align = alTop
        Caption = 'Texto Principal:'
        AutoSize = True
      end
      object textoLetra: TbsSkinMemo
        Tag = 9999
        Left = 0
        Top = 19
        Width = 281
        Height = 41
        Align = alClient
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 13
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          'bsSkinMemo3')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
        OnChange = textoLetraChange
        Transparent = False
        WallpaperStretch = False
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clBlack
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        UseSkinFont = True
        UseSkinFontColor = True
        BitMapBG = True
        VScrollBar = bsSkinScrollBar2
        SkinData = DM.bsSkinData1
        SkinDataName = 'memo'
      end
      object bsSkinScrollBar2: TbsSkinScrollBar
        Left = 281
        Top = 19
        Width = 19
        Height = 41
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
        Enabled = False
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
    end
    object Panel6: TbsSkinPanel
      Left = 0
      Top = 110
      Width = 300
      Height = 19
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
      Caption = 'Panel4'
      Align = alTop
      object bsSkinStdLabel10: TbsSkinLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 294
        Height = 13
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
        Transparent = True
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
        Caption = 'Slides:'
        AutoSize = True
      end
    end
  end
  object lbTempos: TListBox
    Left = 1125
    Top = 99
    Width = 138
    Height = 213
    TabStop = False
    Align = alRight
    ItemHeight = 13
    TabOrder = 4
    Visible = False
  end
  object Panel7: TPanel
    Left = 559
    Top = 99
    Width = 566
    Height = 213
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object pnlProgress: TGridPanel
      Left = 0
      Top = 174
      Width = 566
      Height = 39
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlProgress'
      Color = clBlack
      ColumnCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 50.000000000000000000
        end
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 100.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 1
          Control = gSlide
          Row = 0
        end
        item
          Column = 1
          Control = gSlideTotal
          Row = 1
        end
        item
          Column = 2
          Control = lblTempo
          Row = 0
          RowSpan = 2
        end>
      ParentBackground = False
      RowCollection = <
        item
          Value = 50.001144400448600000
        end
        item
          Value = 49.998855599551390000
        end>
      ShowCaption = False
      TabOrder = 2
      object gSlide: TbsSkinGauge
        Left = 50
        Top = 0
        Width = 416
        Height = 19
        HintImageIndex = 0
        TabOrder = 0
        SkinData = DM.bsSkinData1
        SkinDataName = 'gauge'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        UseSkinSize = True
        ShowProgressText = False
        ShowPercent = False
        MinValue = 0
        MaxValue = 1
        Value = 1
        Vertical = False
        ProgressAnimationPause = 3000
        Align = alClient
      end
      object gSlideTotal: TbsSkinGauge
        Left = 50
        Top = 19
        Width = 416
        Height = 20
        HintImageIndex = 0
        TabOrder = 1
        SkinDataName = 'gauge'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        UseSkinSize = True
        ShowProgressText = False
        ShowPercent = False
        MinValue = 0
        MaxValue = 1
        Value = 1
        Vertical = False
        ProgressAnimationPause = 3000
        Align = alClient
      end
      object lblTempo: TbsSkinStdLabel
        AlignWithMargins = True
        Left = 476
        Top = 0
        Width = 90
        Height = 39
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        EllipsType = bsetNone
        UseSkinFont = True
        UseSkinColor = True
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWhite
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        SkinDataName = 'label'
        Align = alClient
        AutoSize = False
        ExplicitLeft = 429
      end
    end
    object areaPanel: TPanel
      Left = 0
      Top = 0
      Width = 566
      Height = 133
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Panel: TPanel
        Left = 0
        Top = 0
        Width = 566
        Height = 133
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel'
        ParentBackground = False
        ShowCaption = False
        TabOrder = 0
        object pnlLetra: TPanel
          Left = 0
          Top = 0
          Width = 566
          Height = 133
          Align = alClient
          BevelOuter = bvNone
          Color = clBlack
          Ctl3D = False
          DoubleBuffered = False
          ParentBackground = False
          ParentCtl3D = False
          ParentDoubleBuffered = False
          ShowCaption = False
          TabOrder = 0
          object imgFundo: TImage
            Left = 16
            Top = 15
            Width = 65
            Height = 50
            Center = True
            Stretch = True
            Transparent = True
          end
          object imgFundoTexto: TImage
            Left = 40
            Top = 40
            Width = 105
            Height = 57
            Picture.Data = {
              0954506E67496D61676589504E470D0A1A0A0000000D494844520000000A0000
              000A08060000008D32CFBD000000097048597300000B1300000B1301009A9C18
              000039EC69545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F
              787061636B657420626567696E3D22EFBBBF222069643D2257354D304D704365
              6869487A7265537A4E54637A6B633964223F3E0A3C783A786D706D6574612078
              6D6C6E733A783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D
              2241646F626520584D5020436F726520352E362D633133382037392E31353938
              32342C20323031362F30392F31342D30313A30393A3031202020202020202022
              3E0A2020203C7264663A52444620786D6C6E733A7264663D22687474703A2F2F
              7777772E77332E6F72672F313939392F30322F32322D7264662D73796E746178
              2D6E7323223E0A2020202020203C7264663A4465736372697074696F6E207264
              663A61626F75743D22220A202020202020202020202020786D6C6E733A786D70
              3D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A
              202020202020202020202020786D6C6E733A786D704D4D3D22687474703A2F2F
              6E732E61646F62652E636F6D2F7861702F312E302F6D6D2F220A202020202020
              202020202020786D6C6E733A73744576743D22687474703A2F2F6E732E61646F
              62652E636F6D2F7861702F312E302F73547970652F5265736F75726365457665
              6E7423220A202020202020202020202020786D6C6E733A64633D22687474703A
              2F2F7075726C2E6F72672F64632F656C656D656E74732F312E312F220A202020
              202020202020202020786D6C6E733A70686F746F73686F703D22687474703A2F
              2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F220A2020
              20202020202020202020786D6C6E733A746966663D22687474703A2F2F6E732E
              61646F62652E636F6D2F746966662F312E302F220A2020202020202020202020
              20786D6C6E733A657869663D22687474703A2F2F6E732E61646F62652E636F6D
              2F657869662F312E302F223E0A2020202020202020203C786D703A4372656174
              6F72546F6F6C3E41646F62652050686F746F73686F7020434320323031372028
              57696E646F7773293C2F786D703A43726561746F72546F6F6C3E0A2020202020
              202020203C786D703A437265617465446174653E323031372D31322D31385431
              313A34343A31332D30323A30303C2F786D703A437265617465446174653E0A20
              20202020202020203C786D703A4D65746164617461446174653E323031372D31
              322D31385431313A34343A31332D30323A30303C2F786D703A4D657461646174
              61446174653E0A2020202020202020203C786D703A4D6F64696679446174653E
              323031372D31322D31385431313A34343A31332D30323A30303C2F786D703A4D
              6F64696679446174653E0A2020202020202020203C786D704D4D3A496E737461
              6E636549443E786D702E6969643A35633533323462382D383263662D66323430
              2D613361612D6562386362373537363763663C2F786D704D4D3A496E7374616E
              636549443E0A2020202020202020203C786D704D4D3A446F63756D656E744944
              3E61646F62653A646F6369643A70686F746F73686F703A37373862633733322D
              653366392D313165372D623534372D3839393934623832663438643C2F786D70
              4D4D3A446F63756D656E7449443E0A2020202020202020203C786D704D4D3A4F
              726967696E616C446F63756D656E7449443E786D702E6469643A313661643033
              38642D366266302D396234352D396636332D3461303163626561656533343C2F
              786D704D4D3A4F726967696E616C446F63756D656E7449443E0A202020202020
              2020203C786D704D4D3A486973746F72793E0A2020202020202020202020203C
              7264663A5365713E0A2020202020202020202020202020203C7264663A6C6920
              7264663A7061727365547970653D225265736F75726365223E0A202020202020
              2020202020202020202020203C73744576743A616374696F6E3E637265617465
              643C2F73744576743A616374696F6E3E0A202020202020202020202020202020
              2020203C73744576743A696E7374616E636549443E786D702E6969643A313661
              64303338642D366266302D396234352D396636332D3461303163626561656533
              343C2F73744576743A696E7374616E636549443E0A2020202020202020202020
              202020202020203C73744576743A7768656E3E323031372D31322D3138543131
              3A34343A31332D30323A30303C2F73744576743A7768656E3E0A202020202020
              2020202020202020202020203C73744576743A736F6674776172654167656E74
              3E41646F62652050686F746F73686F702043432032303137202857696E646F77
              73293C2F73744576743A736F6674776172654167656E743E0A20202020202020
              20202020202020203C2F7264663A6C693E0A2020202020202020202020202020
              203C7264663A6C69207264663A7061727365547970653D225265736F75726365
              223E0A2020202020202020202020202020202020203C73744576743A61637469
              6F6E3E73617665643C2F73744576743A616374696F6E3E0A2020202020202020
              202020202020202020203C73744576743A696E7374616E636549443E786D702E
              6969643A35633533323462382D383263662D663234302D613361612D65623863
              62373537363763663C2F73744576743A696E7374616E636549443E0A20202020
              20202020202020202020202020203C73744576743A7768656E3E323031372D31
              322D31385431313A34343A31332D30323A30303C2F73744576743A7768656E3E
              0A2020202020202020202020202020202020203C73744576743A736F66747761
              72654167656E743E41646F62652050686F746F73686F70204343203230313720
              2857696E646F7773293C2F73744576743A736F6674776172654167656E743E0A
              2020202020202020202020202020202020203C73744576743A6368616E676564
              3E2F3C2F73744576743A6368616E6765643E0A20202020202020202020202020
              20203C2F7264663A6C693E0A2020202020202020202020203C2F7264663A5365
              713E0A2020202020202020203C2F786D704D4D3A486973746F72793E0A202020
              2020202020203C64633A666F726D61743E696D6167652F706E673C2F64633A66
              6F726D61743E0A2020202020202020203C70686F746F73686F703A436F6C6F72
              4D6F64653E333C2F70686F746F73686F703A436F6C6F724D6F64653E0A202020
              2020202020203C746966663A4F7269656E746174696F6E3E313C2F746966663A
              4F7269656E746174696F6E3E0A2020202020202020203C746966663A58526573
              6F6C7574696F6E3E3732303030302F31303030303C2F746966663A585265736F
              6C7574696F6E3E0A2020202020202020203C746966663A595265736F6C757469
              6F6E3E3732303030302F31303030303C2F746966663A595265736F6C7574696F
              6E3E0A2020202020202020203C746966663A5265736F6C7574696F6E556E6974
              3E323C2F746966663A5265736F6C7574696F6E556E69743E0A20202020202020
              20203C657869663A436F6C6F7253706163653E36353533353C2F657869663A43
              6F6C6F7253706163653E0A2020202020202020203C657869663A506978656C58
              44696D656E73696F6E3E31303C2F657869663A506978656C5844696D656E7369
              6F6E3E0A2020202020202020203C657869663A506978656C5944696D656E7369
              6F6E3E31303C2F657869663A506978656C5944696D656E73696F6E3E0A202020
              2020203C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A52
              44463E0A3C2F783A786D706D6574613E0A202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020200A20202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020200A2020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020202020202020200A
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020200A202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020200A20202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020200A2020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020200A202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020200A20202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020202020200A2020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20200A2020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020200A202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020200A20202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020200A2020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020200A202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020200A20202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              0A20202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020200A2020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020200A202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020200A20202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020200A2020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020200A202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020200A20
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020200A20202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020200A2020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020200A202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020200A20202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020200A2020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020202020200A202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              200A202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020200A20202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020200A2020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020200A202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020200A20202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020200A2020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020202020202020200A
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020200A202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020200A20202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020200A2020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020200A202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020200A20202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020202020200A2020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20200A2020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020200A202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020200A20202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020200A2020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020200A202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020200A20202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              0A20202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020200A2020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020200A202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020200A20202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020200A2020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020200A202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020200A20
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020200A20202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020200A2020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020200A202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020200A20202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020200A2020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020202020200A202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              200A202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020200A20202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020200A2020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020200A202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020200A20202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020200A2020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020202020202020200A
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020200A202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020200A20202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020200A2020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020200A202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020200A20202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020202020200A2020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20200A2020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020200A202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020200A20202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020200A2020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020200A202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020200A20202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              0A20202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020200A2020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020200A202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020200A20202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020200A2020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020200A202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020200A20
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020200A20202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020200A2020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020200A202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020200A20202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020200A2020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020202020200A202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              200A202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020200A20202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020200A2020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020200A202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020200A20202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020200A2020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020202020202020200A
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020200A202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020200A20202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020200A2020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020200A202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020200A20202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020202020200A2020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20200A2020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020200A202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020200A20202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020200A2020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020200A202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020200A20202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              0A20202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020200A2020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020200A202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020200A20202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020200A2020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020200A202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020200A20
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020200A20202020202020202020202020202020202020202020202020202020
              0A3C3F787061636B657420656E643D2277223F3E35E3E6390000001549444154
              78DA63646060D8CF4004601C55485F85007F5C07812DBC10C50000000049454E
              44AE426082}
            Stretch = True
            Visible = False
          end
          object lblLetra: TbsSkinStdLabel
            Left = 52
            Top = 0
            Width = 224
            Height = 40
            EllipsType = bsetNone
            UseSkinFont = False
            UseSkinColor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWhite
            DefaultFont.Height = 10
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            SkinData = DM.bsSkinData1
            SkinDataName = 'label'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = 40
            Font.Name = 'Arial Narrow'
            Font.Style = [fsBold]
            Alignment = taCenter
            Caption = 'CARREGANDO...'
            Color = clWhite
            ParentColor = False
            ParentFont = False
            Layout = tlCenter
            Visible = False
            WordWrap = True
          end
          object lblLetra_aux: TbsSkinStdLabel
            Left = 60
            Top = 71
            Width = 224
            Height = 40
            EllipsType = bsetNone
            UseSkinFont = False
            UseSkinColor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWhite
            DefaultFont.Height = 10
            DefaultFont.Name = 'Tahoma'
            DefaultFont.Style = []
            SkinData = DM.bsSkinData1
            SkinDataName = 'label'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = 40
            Font.Name = 'Arial Narrow'
            Font.Style = [fsBold]
            Alignment = taCenter
            Caption = 'CARREGANDO...'
            Color = clWhite
            ParentColor = False
            ParentFont = False
            Layout = tlCenter
            Visible = False
            WordWrap = True
          end
        end
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 133
      Width = 566
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel3'
      Color = clBlack
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      object GridPanel2: TGridPanel
        Left = 0
        Top = 0
        Width = 566
        Height = 41
        Align = alClient
        BevelOuter = bvNone
        Caption = 'GridPanel1'
        Color = clBlack
        ColumnCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 30.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 30.000000000000000000
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
            Value = 30.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 30.000000000000000000
          end>
        ControlCollection = <
          item
            Column = 1
            Control = bsSkinSpeedButton1
            Row = 0
          end
          item
            Column = 2
            Control = btPausePlay
            Row = 0
          end
          item
            Column = 4
            Control = bsSkinSpeedButton3
            Row = 0
          end
          item
            Column = 5
            Control = bsSkinSpeedButton4
            Row = 0
          end
          item
            Column = 0
            Control = bsSkinSpeedButton5
            Row = 0
          end
          item
            Column = 3
            Control = Panel1
            Row = 0
          end>
        ParentBackground = False
        RowCollection = <
          item
            Value = 100.000000000000000000
          end
          item
            SizeStyle = ssAuto
          end>
        ShowCaption = False
        TabOrder = 0
        object bsSkinSpeedButton1: TbsSkinSpeedButton
          Left = 30
          Top = 0
          Width = 30
          Height = 41
          HintImageIndex = 0
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 22
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          Layout = blGlyphTop
          OnClick = bsSkinSpeedButton1Click
          ExplicitLeft = 8
          ExplicitTop = 8
          ExplicitWidth = 20
          ExplicitHeight = 25
        end
        object btPausePlay: TbsSkinSpeedButton
          Left = 60
          Top = 0
          Width = 30
          Height = 41
          HintImageIndex = 0
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 8
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          Layout = blGlyphTop
          OnClick = btPausePlayClick
          ExplicitLeft = 8
          ExplicitTop = 8
          ExplicitWidth = 20
          ExplicitHeight = 25
        end
        object bsSkinSpeedButton3: TbsSkinSpeedButton
          Left = 506
          Top = 0
          Width = 30
          Height = 41
          HintImageIndex = 0
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 21
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          Layout = blGlyphTop
          OnClick = bsSkinSpeedButton3Click
          ExplicitLeft = 8
          ExplicitTop = 8
          ExplicitWidth = 20
          ExplicitHeight = 25
        end
        object bsSkinSpeedButton4: TbsSkinSpeedButton
          Left = 536
          Top = 0
          Width = 30
          Height = 41
          HintImageIndex = 0
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 78
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          Layout = blGlyphTop
          OnClick = bsSkinSpeedButton4Click
          ExplicitLeft = 395
          ExplicitTop = 6
        end
        object bsSkinSpeedButton5: TbsSkinSpeedButton
          Left = 0
          Top = 0
          Width = 30
          Height = 41
          HintImageIndex = 0
          SkinDataName = 'resizetoolbutton'
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 13
          DefaultFont.Name = 'Tahoma'
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = True
          CheckedMode = False
          ImageList = DM.ico_24x24
          UseSkinSize = True
          UseSkinFontColor = True
          WidthWithCaption = 0
          WidthWithoutCaption = 0
          ImageIndex = 79
          RepeatMode = False
          RepeatInterval = 100
          Transparent = True
          Flat = True
          AllowAllUp = False
          Down = False
          GroupIndex = 0
          ShowCaption = True
          NumGlyphs = 1
          Align = alClient
          Spacing = 1
          Layout = blGlyphTop
          OnClick = bsSkinSpeedButton5Click
          ExplicitLeft = 8
        end
        object Panel1: TPanel
          Left = 90
          Top = 0
          Width = 416
          Height = 41
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel1'
          ShowCaption = False
          TabOrder = 0
          object lblSlides: TbsSkinLabel
            Left = 0
            Top = 0
            Width = 416
            Height = 41
            Margins.Left = 10
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            HintImageIndex = 0
            TabOrder = 0
            SkinDataName = 'label'
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWhite
            DefaultFont.Height = 30
            DefaultFont.Name = 'DIN Condensed'
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            Transparent = True
            ShadowEffect = False
            ShadowColor = clBlack
            ShadowOffset = 0
            ShadowSize = 3
            ReflectionEffect = False
            ReflectionOffset = -5
            EllipsType = bsetNoneEllips
            UseSkinSize = False
            UseSkinFontColor = False
            BorderStyle = bvFrame
            Alignment = taCenter
            Align = alClient
            Caption = 'SLIDE    1 / 5'
            AutoSize = False
          end
        end
      end
    end
  end
  object tmrSlideCarregado: TTimer
    Interval = 1
    OnTimer = tmrSlideCarregadoTimer
    Left = 128
    Top = 280
  end
  object tmrTempo: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrTempoTimer
    Left = 96
    Top = 200
  end
end
