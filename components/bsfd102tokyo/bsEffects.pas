{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       BusinessSkinForm                                            }
{       Version 11.51                                               }
{                                                                   }
{       Copyright (c) 2000-2016 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit bseffects;

{$I bsdefine.inc}

{$O-}
{$R-}
{$Q-}
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses SysUtils, Classes, Windows, Graphics, Math, Clipbrd;

type

  { Color type }

  PbsColor = ^TbsColor;
  TbsColor = type cardinal;

  PbsColorRec = ^TbsColorRec;
  TbsColorRec = packed record
    case Cardinal of
      0: (Color: Cardinal);
      2: (HiWord, LoWord: Word);
      3: (B, G, R, A: Byte);
    end;

  PbsColorRecBor = ^TbsColorRecBor;
  TbsColorRecBor = packed record
    case Cardinal of
      0: (Color: Cardinal);
      2: (HiWord, LoWord: Word);
      3: (R, G, B, A: Byte);
    end;

  PbsColorArray = ^TbsColorArray;
  TbsColorArray = array [0..0] of TbsColor;

  PbsColorRecArray = ^TbsColorRecArray;
  TbsColorRecArray = array [0..0] of TbsColorRec;

  TArrayOfseColor = array of TbsColor;

const

  bsTransparent         = $007F007F;
  AlphaMask              = $FF000000;

  cbsBlack               : TbsColor = $FF000000;
  cbsGray                : TbsColor = $FF7F7F7F;
  cbsWhite               : TbsColor = $FFFFFFFF;
  cbsMaroon              : TbsColor = $FF7F0000;
  cbsGreen               : TbsColor = $FF007F00;
  cbsOlive               : TbsColor = $FF7F7F00;
  cbsNavy                : TbsColor = $FF00007F;
  cbsPurple              : TbsColor = $FF7F007F;
  cbsTeal                : TbsColor = $FF007F7F;
  cbsRed                 : TbsColor = $FFFF0000;
  cbsLime                : TbsColor = $FF00FF00;
  cbsYellow              : TbsColor = $FFFFFF00;
  cbsBlue                : TbsColor = $FF0000FF;
  cbsFuchsia             : TbsColor = $FFFF00FF;
  cbsAqua                : TbsColor = $FF00FFFF;

  cbsMenu                : TbsColor = $FFEDEDEE;
  cbsBorder              : TbsColor = $FF003399;
  cbsWindow              : TbsColor = $FFEBEBEE;
  cbsBtnFace             : TbsColor = $FFD2D2D2;
  cbsBtnShadow           : TbsColor = $FFA8A8A8;
  cbsHotHighlight        : TbsColor = $FFF8C751;
  cbsHighlight           : TbsColor = $FF64A0FF;
  cbsHintBack            : TbsColor = $FFEBEBEE;
  cbsNone                : TbsColor = $33333333;

  bsTransparentVar	 : TbsColor = bsTransparent;

type

  TbsBitmapLink = class;

{ TbsBitmap the main class }

  TbsBitmap = class(TPersistent)
  private
    FBits: PbsColorArray;
    FWidth, FHeight: integer;
    FName: string;
    FBitmapInfo: TBitmapInfo;
    FHandle: HBITMAP;
    FDC: HDC;
    FCanvas: TCanvas;
    FAlphaBlend: boolean;
    FTransparent: boolean;
    FNewFormat: boolean;
    function  GetPixel(X, Y: Integer): TbsColor;
    procedure SetPixel(X, Y: Integer; Value: TbsColor);
    function GetPixelPtr(X, Y: Integer): PbsColor;
    function GetScanLine(Y: Integer): PbsColorArray;
    function GetCanvas: TCanvas;
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    { }
    procedure SetSize(AWidth, AHeight: Integer);
    procedure Clear(Color: TbsColor);
    function Empty: boolean;
    { I/O }
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromPcxStream(Stream: TStream);
    procedure LoadFromResource(const ResFileName, ResName: string);
    { BitmapLink }
    function GetBitmapLink(Rect: TRect): TbsBitmapLink; overload;
    function GetBitmapLink(Rect: string): TbsBitmapLink; overload;
    { Checking }
    procedure CheckingTransparent(Color: TbsColor = bsTransparent); overload;
    procedure CheckingTransparent(ARect: TRect; Color: TbsColor = bsTransparent); overload;
    procedure CheckingAlphaBlend; overload;
    procedure CheckingAlphaBlend(ARect: TRect); overload;
    procedure SetAlpha(Alpha: byte); overload;
    procedure SetAlpha(Alpha: byte; Rect: TRect); overload;
    procedure CheckRGBA;
    procedure CheckRGBA2;
    { Color transition }
    procedure SetBitmapHue(Hue: integer);
    procedure ChangeBitmapSat(DeltaSat: integer);
    procedure ChangeBitmapHue(DeltaHue: integer);
    procedure ChangeBitmapBrightness(DeltaBrightness: integer);
    { Manipulation }
    procedure FlipVert;
    procedure Reflection;
    procedure Reflection2;
    procedure Reflection3;
    { Paint routines }
    procedure MoveTo(X, Y: integer);
    procedure LineTo(X, Y: integer; Color: TbsColor);
    procedure DrawGraphic(Graphic: TGraphic; DstRect: TRect);
    procedure FillRect(R: TRect; Color: TbsColor);
    procedure FillRoundRect(R: TRect; Radius: integer; Color: TbsColor);
    procedure FillHalftoneRect(R: TRect; Color, HalfColor: TbsColor);
    procedure FillGradientRect(Rect: TRect; BeginColor, EndColor: TbsColor; Vertical: boolean);
    procedure FillRadialGradientRect(Rect: TRect; BeginColor, EndColor: TbsColor; Pos: TPoint);
    procedure FillEllipse(R: TRect; Color: TbsColor);
    procedure FillPolygon(Points: array of TPoint; Color: TColor);
    procedure FillHalftonePolygon(Points: array of TPoint; Color, HalfColor: TbsColor);
    procedure DrawEdge(R: TRect; RaisedColor, SunkenColor: TbsColor);
    procedure DrawBevel(R: TRect; Color: TbsColor; Width: integer; Down: boolean);
    procedure DrawRect(R: TRect; Color: TbsColor);
    procedure DrawFocusRect(R: TRect; Color: TbsColor);
    procedure DrawRoundRect(R: TRect; Radius: integer; Color: TbsColor);
    procedure DrawLine(R: TRect; Color: TbsColor);
    procedure DrawEllipse(R: TRect; Color: TbsColor);
    procedure DrawPolygon(Points: array of TPoint; Color: TColor);
    function DrawText(AText: WideString; var Bounds: TRect; Flag: cardinal): integer; overload;
    function DrawText(AText: WideString; X, Y: integer): integer; overload;
    function DrawVerticalText(AText: WideString; Bounds: TRect; Flag: cardinal; FromTop: boolean): integer;
    function TextWidth(AText: WideString; Flags: Integer = 0): integer;
    function TextHeight(AText: WideString): integer;
    { Draw to Canvas }
    procedure Draw(DC: HDC; X, Y: integer); overload;
    procedure Draw(DC: HDC; X, Y: integer; SrcRect: TRect); overload;
    procedure Draw(DC: HDC; DstRect: TRect); overload;
    procedure Draw(DC: HDC; DstRect, SrcRect: TRect); overload;
    procedure Draw(Canvas: TCanvas; X, Y: integer); overload;
    procedure Draw(Canvas: TCanvas; X, Y: integer; SrcRect: TRect); overload;
    procedure Draw(Canvas: TCanvas; DstRect: TRect); overload;
    procedure Draw(Canvas: TCanvas; DstRect, SrcRect: TRect); overload;
    { Draw to TbsBitmap }
    procedure Draw(Bitmap: TbsBitmap; X, Y: integer); overload;
    procedure Draw(Bitmap: TbsBitmap; X, Y: integer; SrcRect: TRect); overload;
    procedure Draw(Bitmap: TbsBitmap; DstRect: TRect); overload;
    procedure Draw(Bitmap: TbsBitmap; DstRect, SrcRect: TRect); overload;
    { Complex Draw }
    procedure Tile(DC: HDC; DstRect, SrcRect: TRect); overload;
    procedure Tile(Canvas: TCanvas; DstRect, SrcRect: TRect); overload;
    procedure Tile(Bitmap: TbsBitmap; DstRect, SrcRect: TRect); overload;
    procedure TileClip(DC: HDC; DstRect, DstClip, SrcRect: TRect); overload;
    procedure TileClip(Canvas: TCanvas; DstRect, DstClip, SrcRect: TRect); overload;
    procedure TileClip(Bitmap: TbsBitmap; DstRect, DstClip, SrcRect: TRect); overload;
    { Alpha blend two bitmap }
    procedure MergeDraw(Bitmap: TbsBitmap; X, Y: integer; SrcRect: TRect);
    { Low-level access}
    property Handle: HBITMAP read FHandle;
    property DC: HDC read FDC;
    property Canvas: TCanvas read GetCanvas;
    { Access properties }
    property Bits: PbsColorArray read FBits;
    property Pixels[X, Y: Integer]: TbsColor read GetPixel write SetPixel; default;
    property PixelPtr[X, Y: Integer]: PbsColor read GetPixelPtr;
    property ScanLine[Y: Integer]: PbsColorArray read GetScanLine;
    property Width: integer read FWidth;
    property Height: integer read FHeight;
    { States }
    property AlphaBlend: boolean read FAlphaBlend write FAlphaBlend;
    property Transparent: boolean read FTransparent write FTransparent;
    { Persitent properties }
    property Name: string read FName write FName;
    property NewFormat: boolean read FNewFormat write FNewFormat;
  published
  end;

{ TbsBitmapLink }

  TbsBitmapLink = class(TPersistent)
  private
    FImage: TbsBitmap;
    FRect: TRect;
    FName: string;
    FMaskedBorder: boolean;
    FMaskedAngles: boolean;
    FMasked: boolean;
    function GetBottom: integer;
    function GetLeft: integer;
    function GetRight: integer;
    function GetTop: integer;
    procedure SetBottom(const Value: integer);
    procedure SetLeft(const Value: integer);
    procedure SetRight(const Value: integer);
    procedure SetTop(const Value: integer);
    function GetAssigned: boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);

    procedure CheckingMasked; overload;
    procedure CheckingMasked(Margin: TRect); overload;

    procedure Draw(Canvas: TCanvas; X, Y: integer); overload;
    procedure Draw(Bitmap: TbsBitmap; X, Y: integer); overload;

    property Assigned: boolean read GetAssigned;
    property Image: TbsBitmap read FImage write FImage;
    property Rect: TRect read FRect write FRect;
    property Masked: boolean read FMasked write FMasked;
    property MaskedBorder: boolean read FMaskedBorder write FMaskedBorder;
    property MaskedAngles: boolean read FMaskedAngles write FMaskedAngles;
  published
    property Name: string read FName write FName;
    property Left: integer read GetLeft write SetLeft;
    property Top: integer read GetTop write SetTop;
    property Right: integer read GetRight write SetRight;
    property Bottom: integer read GetBottom write SetBottom;
  end;

{ TbsBitmapList }

  TbsBitmapList = class(TList)
  private
    function GetImage(index: integer): TbsBitmap;
    function GetBitmapByName(index: string): TbsBitmap;
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Clear; override;

    function GetBitmapLink(Image: TbsBitmap; Rect: TRect): TbsBitmapLink; overload;
    function GetBitmapLink(Name: string; Rect: TRect): TbsBitmapLink; overload;
    function GetBitmapLink(Name, Rect: string): TbsBitmapLink; overload;

    property Bitmaps[index: integer]: TbsBitmap read GetImage; default;
    property BitmapByName[index: string]: TbsBitmap read GetBitmapByName;
  end;

{ Color functions }

function bsColor(Color: TColor; A: Byte = $FF): TbsColor; overload;
function bsColor(R, G, B: SmallInt; A: Byte = $FF): TbsColor; overload;
function bsColor(ColorRec: TbsColorRec): TbsColor; overload;

function bsColorToColor(Color: TbsColor): TColor;

function bsColorToColor16(Color: TbsColor): word; // 16-bit, 5-6-5
function bsColorToColor15(Color: TbsColor): word; // 15-bit, 5-5-5

function ChangeColor(Color: TbsColor; Dr, Dg, Db: smallint; Da: smallint = 0): TbsColor; overload;
function ChangeColor(Color: TbsColor; Dx: smallint): TbsColor; overload;
function StdChangeColor(Color: TColor; Dr, Dg, Db: smallint; Da: smallint = 0): TColor; overload;
function StdChangeColor(Color: TColor; Dx: smallint): TColor; overload;

function SunkenColor(Color: TbsColor; Dr, Dg, Db: smallint; Da: smallint = 0): TbsColor; overload;
function SunkenColor(Color: TbsColor; Dx: smallint): TbsColor; overload;
function RaisedColor(Color: TbsColor; Dr, Dg, Db: smallint; Da: smallint = 0): TbsColor; overload;
function RaisedColor(Color: TbsColor; Dx: smallint): TbsColor; overload;

function HSLtoRGB(H, S, L: Single): TbsColor;
procedure RGBtoHSL(RGB: TbsColor; out H, S, L: single);

function SetHue(Color: TbsColor; Hue: integer): TbsColor;
function ChangeSat(Color: TbsColor; DeltaSat: integer): TbsColor;
function ChangeHue(Color: TbsColor; DeltaHue: integer): TbsColor;
function ChangeBrightness(Color: TbsColor; DeltaBrightness: integer): TbsColor;

const

  EnableDibOperation: boolean = true; // Use dib routines from DC


{ Function prototypes }

type
  TbsAlphaBlendPixel = function (Src, Dst: TbsColor): TbsColor;
  TbsAlphaBlendLine = procedure (Src, Dst: PbsColor; Count: Integer);
  TbsTransparentLine = procedure (Src, Dst: PbsColor; Count: Integer);

  TbsMoveLongword = procedure (const Src: Pointer; Dst: Pointer; Count: Integer);

  TbsFillLongword = procedure (Src: Pointer; Count: integer; Value: longword);
  TbsFillLongwordRect = procedure (Src: Pointer; W, H, X1, Y1, X2, Y2: integer;
    Value: longword);

  TbsFillAlpha = procedure (Src: Pointer; Count: integer; Alpha: byte);
  TbsFillAlphaRect = procedure (Src: Pointer; W, H, X1, Y1, X2, Y2: integer; Alpha: byte);

  TbsClearAlpha = procedure (Src: Pointer; Count: integer; Value: longword);

{ Function variables }

var
  PixelAlphaBlendFunc: TbsAlphaBlendPixel;
  LineAlphaBlendFunc: TbsAlphaBlendLine;
  LineTransparentFunc: TbsTransparentLine;

  MoveLongwordFunc: TbsMoveLongword;
  FillLongwordFunc: TbsFillLongword;
  FillLongwordRectFunc: TbsFillLongwordRect;

  FillAlphaFunc: TbsFillAlpha;
  FillAlphaRectFunc: TbsFillAlphaRect;

  ClearAlphaFunc: TbsClearAlpha;

function MulDiv16(Number, Numerator, Denominator: Word): Word;

function FromRGB(Color: longword): longword;
function ToRGB(Color32: longword): longword;


{ Function prototypes }

type
  TbsStretchToDCOpaque = procedure (DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
    SrcBmp: TbsBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
  TbsStretchToDCTransparent = procedure(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
    SrcBmp: TbsBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
  TbsStretchToDCAlphaBlend = procedure (DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
    SrcBmp: TbsBitmap; SrcX, SrcY, SrcW, SrcH: Integer);

  TbsStretchToDibOpaque = procedure (Bits: Pointer; DstRect, DstClip: TRect;
    BitsW, BitsH: integer; Src: TbsBitmap; SrcRect: TRect);
  TbsStretchToDibTransparent = procedure(Bits: Pointer; DstRect, DstClip: TRect;
    BitsW, BitsH: integer; Src: TbsBitmap; SrcRect: TRect);
  TbsStretchToDibAlphaBlend = procedure (Bits: Pointer; DstRect, DstClip: TRect;
    BitsW, BitsH: integer; Src: TbsBitmap; SrcRect: TRect);

  TbsStretchOpaque = procedure(Dst: TbsBitmap; DstRect, DstClip: TRect; Src: TbsBitmap;
    SrcRect: TRect);
  TbsStretchTransparent = procedure(Dst: TbsBitmap; DstRect, DstClip: TRect; Src: TbsBitmap;
    SrcRect: TRect);
  TbsStretchAlphaBlend = procedure(Dst: TbsBitmap; DstRect, DstClip: TRect; Src: TbsBitmap;
    SrcRect: TRect);

  TbsBltOpaque = procedure(Dst: TbsBitmap; DstRect: TRect; Src: TbsBitmap;
    SrcX, SrcY: Integer);
  TbsBltTransparent = procedure(Dst: TbsBitmap; DstRect: TRect; Src: TbsBitmap;
    SrcX, SrcY: Integer);
  TbsBltAlphaBlend = procedure(Dst: TbsBitmap; DstRect: TRect; Src: TbsBitmap;
    SrcX, SrcY: Integer);

  TbsGetBitsFromDC = function(DC: HDC; var Width, Height, BitCount: integer): Pointer;

{ Function variables }

var
  { DC }
  StretchToDCOpaqueFunc: TbsStretchToDCOpaque;
  StretchToDCAlphaBlendFunc: TbsStretchToDCAlphaBlend;
  StretchToDCTransparentFunc: TbsStretchToDCTransparent;
  { Dib }
  GetBitsFromDCFunc: TbsGetBitsFromDC;
  StretchToDibOpaqueFunc: TbsStretchToDibOpaque;
  StretchToDibAlphaBlendFunc: TbsStretchToDibAlphaBlend;
  StretchToDibTransparentFunc: TbsStretchToDibTransparent;
  { bsBitmap }
  BltOpaqueFunc: TbsBltOpaque;
  BltAlphaBlendFunc: TbsBltAlphaBlend;
  BltTransparentFunc: TbsBltTransparent;
  StretchOpaqueFunc: TbsStretchOpaque;
  StretchAlphaBlendFunc: TbsStretchAlphaBlend;
  StretchTransparentFunc: TbsStretchTransparent;

  type
  
  TFColor = record
    b, g, r: Byte;
  end;

  PFColor = ^TFColor;

  TLine = array[0..0] of TFColor;
  PLine = ^TLine;

  TbsEffectBmp = class(TObject)
  private
    procedure SetPixel(x,y: Integer; Clr: Integer);
    function GetPixel(x,y: Integer): Integer;
    procedure SetLine(y: Integer; Line: Pointer);
    function GetLine(y:Integer): Pointer;
  public
    Handle, Width, Height, Size: Integer;
    Bits: Pointer;
    BmpHeader: TBITMAPINFOHEADER;
    BmpInfo: TBITMAPINFO;
    constructor Create(cx, cy: Integer);
    constructor CreateFromhWnd(hBmp: Integer);
    constructor CreateCopy(hBmp: TbsEffectBmp);
    destructor  Destroy; override;
    property Pixels[x,y: Integer]: Integer read GetPixel write SetPixel;
    property ScanLines[y:Integer]: Pointer read GetLine write SetLine;
    procedure GetScanLine(y: Integer; Line:Pointer);
    procedure Resize(Dst: TbsEffectBmp);
    procedure Draw(hDC, x, y: Integer);
    procedure Stretch(hDC, x, y, cx, cy: Integer);
    procedure DrawRect(hDC, hx, hy, x, y, cx, cy: Integer);
    procedure CopyRect(BMP: TbsEffectBmp; Rct:TRect; StartX, StartY: Integer);
    procedure MorphRect(BMP: TbsEffectBmp; Kf: Double; Rct: TRect;
                        StartX, StartY: Integer);
    procedure Morph(BMP: TbsEffectBmp; Kf: Double);
    procedure MorphHGrad(BMP: TbsEffectBMP; Kf: Double);
    procedure MorphVGrad(BMP: TbsEffectBMP; Kf: Double);
    procedure MorphGrad(BMP: TbsEffectBMP; Kf: Double);
    procedure MorphLeftGrad(BMP: TbsEffectBMP; Kf: Double);
    procedure MorphRightGrad(BMP: TbsEffectBMP; Kf: Double);
    procedure MorphLeftSlide(BMP: TbsEffectBMP; Kf: Double);
    procedure MorphRightSlide(BMP: TbsEffectBMP; Kf: Double);
    procedure MorphPush(BMP: TbsEffectBMP; Kf: Double);
    procedure ChangeBrightness(Kf: Double);
    procedure ChangeDarkness(Kf: Double);
    procedure GrayScale;
    procedure SplitBlur(Amount: Integer);
    procedure Mosaic(ASize: Integer);
    procedure Invert;
    procedure AddColorNoise(Amount: Integer);
    procedure AddMonoNoise(Amount: Integer);
    procedure Rotate90_1(Dst: TbsEffectBmp);
    procedure Rotate90_2(Dst: TbsEffectBmp);
    procedure FlipVert(Dst: TbsEffectBmp);
    procedure Wave(XDIV, YDIV, RatioVal: Integer);
    procedure MaskAntialiasing(Msk: TbsEffectBmp; Amount: Integer);
    procedure MaskBlur(Msk: TbsEffectBmp; Amount: Integer);
    procedure MaskFillColor(Msk: TbsEffectBmp; C: TColor; kf: Double);
  end;

  PEfBmp = ^TbsEffectBmp;

  procedure CreateAlphaByMask(Bmp, MaskBmp: TbsBitmap);
  procedure CreateAlphaByMask2(Bmp, MaskBmp: TbsBitmap);

  procedure Blur(const Bitmap: TbsBitmap; const Radius: integer);

  procedure DrawBlurMarker(const Canvas: TCanvas;
    ARect: TRect; MarkerColor: cardinal = $202020);

{for Alpha bitmap =============================================================}

type
 TTokenSeparators = set of char;

 TbsBlendFunction = packed record
    BlendOp: BYTE;
    BlendFlags: BYTE;
    SourceConstantAlpha: BYTE;
    AlphaFormat: BYTE;
  end;

function ReadString(S: TStream): string;
procedure WriteString(S: TStream; Value: string);
function GetToken(var S: string): string; overload;
function GetToken(var S: string; Separators: string): string; overload;
function GetToken(var S: string; Separators: TTokenSeparators): string; overload;
function RectToString(R: TRect): string;
function StringToRect(S: string): TRect;

function HasMMX: Boolean;
procedure EMMS;
function IsMsImg: boolean;


var
    TransparentBltFunc: function (hdcDest: HDC; nXOriginDest, nYOriginDest, nWidthDest,
    nHeightDest: Integer; hdcSrc: HDC; nXOriginSrc, nYOriginSrc, nWidthSrc,
    nHeightSrc: Integer; Color: Longint): BOOL; stdcall;

    AlphaBlendFunc: function (DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer;
      p11: TbsBlendFunction): BOOL; stdcall;


implementation {===============================================================}

var
  BitmapList: TList = nil;

function RectWidth(R: TRect): Integer;
begin
  Result := R.Right - R.Left;
end;

function RectHeight(R: TRect): Integer;
begin
  Result := R.Bottom - R.Top;
end;


{ BitmapList Routines }

procedure AddBitmapToList(B: TbsBitmap);
begin
  if BitmapList = nil then
  BitmapList := TList.Create;
  BitmapList.Add(B);
end;

procedure RemoveBitmapFromList(B: TbsBitmap);
begin
  if BitmapList <> nil then
    BitmapList.Remove(B);
end;

function FindBitmapByDC(DC: HDC): TbsBitmap;
var
  i: integer;
begin
  for i := 0 to BitmapList.Count - 1 do
    if TbsBitmap(BitmapList[i]).DC = DC then
    begin
      Result := TbsBitmap(BitmapList[i]);
      Exit;
    end;
  Result := nil;
end;

procedure FreeBitmapList;
begin
  if BitmapList <> nil then FreeAndNil(BitmapList);
end;

{ Color function }

function bsColor(Color: TColor; A: Byte = $FF): TbsColor;
var
  C: TColor;
  Tmp: cardinal;
begin
  C := ColorToRGB(Color);
  Tmp := A;
  Result := FromRGB(C) + (Tmp shl 24);
end;

function bsColor(R, G, B: SmallInt; A: Byte = $FF): TbsColor;
begin
  if R > $FF then R := $FF;
  if G > $FF then G := $FF;
  if B > $FF then B := $FF;
  if R < 0 then R := 0;
  if G < 0 then G := 0;
  if B < 0 then B := 0;

  TbsColorRec(Result).R := R;
  TbsColorRec(Result).G := G;
  TbsColorRec(Result).B := B;
  TbsColorRec(Result).A := A;
end;

function bsColor(ColorRec: TbsColorRec): TbsColor;
begin
  Result := ToRGB(Longword(ColorRec));
end;

function bsColorToColor(Color: TbsColor): TColor;
begin
  Result := ToRGB(Color);
end;

function bsColorToColor16(Color: TbsColor): word; // 16-bit, 5-6-5
begin
  with TbsColorRec(Color) do
    Result :=
      (R shr 3 shl 11) or  // R-5bit
      (G shr 2 shl 5) or   // G-6bit
      (B shr 3);           // B-5bit
end;

function bsColorToColor15(Color: TbsColor): word; // 15-bit, 5-5-5
begin
  with TbsColorRec(Color) do
    Result :=
      (R shr 3 shl 10) or  // R-5bit
      (G shr 3 shl 5) or   // G-5bit
      (B shr 3);           // B-5bit
end;

{ Color space conversions }

{$Q-}
function HSLtoRGB(H, S, L: Single): TbsColor;
var
  M1, M2: Single;
  R, G, B: Byte;

  function HueToColor(Hue: Single): Byte;
  var
    V: Double;
  begin
    Hue := Hue - Floor(Hue);

    if 6 * Hue < 1 then V := M1 + (M2 - M1) * Hue * 6
    else if 2 * Hue < 1 then V := M2
    else if 3 * Hue < 2 then V := M1 + (M2 - M1) * (2 / 3 - Hue) * 6
    else V := M1;
    Result := Round(255 * V);
  end;
begin
  if S = 0 then
  begin
    R := Round(255 * L);
    G := R;
    B := R;
  end
  else
  begin
    if L <= 0.5 then M2 := L * (1 + S)
    else M2 := L + S - L * S;
    M1 := 2 * L - M2;
    R := HueToColor(H + 1 / 3);
    G := HueToColor(H);
    B := HueToColor(H - 1 / 3)
  end;
  Result := bsColor(R, G, B);
end;

procedure RGBtoHSL(RGB: TbsColor; out H, S, L: single);
var
  R, G, B, D, Cmax, Cmin: Single;
begin
  R := TbsColorRec(RGB).R / 255;
  G := TbsColorRec(RGB).G / 255;
  B := TbsColorRec(RGB).B / 255;
  Cmax := Math.Max(R, Math.Max(G, B));
  Cmin := Math.Min(R, Math.Min(G, B));
  L := (Cmax + Cmin) / 2;

  if Cmax = Cmin then
  begin
    H := 0;
    S := 0
  end
  else
  begin
    D := Cmax - Cmin;
    if L < 0.5 then S := D / (Cmax + Cmin)
    else S := D / (2 - Cmax - Cmin);
    if R = Cmax then H := (G - B) / D
    else
      if G = Cmax then H  := 2 + (B - R) /D
      else H := 4 + (R - G) / D;
    H := H / 6;
    if H < 0 then H := H + 1
  end;
end;

function SetHue(Color: TbsColor; Hue: integer): TbsColor;
var
  H, S, L: single;
  HValue: integer;
begin
  RGBtoHSL(Color, H, S, L);

  if Hue > $FF then Hue := $Ff;
  if Hue < 0 then Hue := 0;

  Result := HSLtoRGB(Hue / 255, S, L);
end;

function ChangeSat(Color: TbsColor; DeltaSat: integer): TbsColor;
var
  H, S, L: single;
  SValue: integer;
begin
  RGBtoHSL(Color, H, S, L);

  SValue := Round(S * 255);
  Inc(SValue, DeltaSat);

  if SValue > $FF then SValue := SValue - $FF;
  if SValue < 0 then SValue := $FF + SValue;

  Result := HSLtoRGB(H, SValue / $FF, L);
end;

function ChangeHue(Color: TbsColor; DeltaHue: integer): TbsColor;
var
  H, S, L: single;
  HValue: integer;
begin
  RGBtoHSL(Color, H, S, L);

  HValue := Round(H * 255);
  Inc(HValue, DeltaHue);

  if HValue > 255 then HValue := HValue - 255;
  if HValue < 0 then HValue := 255 + HValue;

  Result := HSLtoRGB(HValue / 255, S, L);
end;

function ChangeBrightness(Color: TbsColor; DeltaBrightness: integer): TbsColor;
var
  R, G, B: integer;
begin
  R := TbsColorRec(Color).R;
  G := TbsColorRec(Color).G;
  B := TbsColorRec(Color).B;

  Inc(R, DeltaBrightness);
  Inc(G, DeltaBrightness);
  Inc(B, DeltaBrightness);

  Result := bsColor(R, G, B);
end;

function ChangeColor(Color: TbsColor; Dr, Dg, Db: smallint; Da: smallint = 0): TbsColor; overload;
begin
  with TbsColorRec(Color) do
    Result := bsColor(R + DR, G + DG, B + DB, A + DA);
end;

function ChangeColor(Color: TbsColor; Dx: smallint): TbsColor; overload;
begin
  Result := ChangeColor(Color, Dx, Dx, Dx);
end;

function StdChangeColor(Color: TColor; Dr, Dg, Db: smallint; Da: smallint = 0): TColor; overload;
begin
  Color := FromRGB(ColorToRGB(Color));
  Color := ChangeColor(Color, Dr, Dg, Db);
  Result := ToRGB(Color);
end;

function StdChangeColor(Color: TColor; Dx: smallint): TColor; overload;
begin
  Result := StdChangeColor(Color, Dx, Dx, Dx);
end;

function SunkenColor(Color: TbsColor; Dr, Dg, Db: smallint; Da: smallint = 0): TbsColor; overload;
begin
  Result := ChangeColor(Color, -Dr, -Dg, -Db, -Da);
end;

function SunkenColor(Color: TbsColor; Dx: smallint): TbsColor; overload;
begin
  Result := ChangeColor(Color, -Dx);
end;

function RaisedColor(Color: TbsColor; Dr, Dg, Db: smallint; Da: smallint = 0): TbsColor; overload;
begin
  Result := ChangeColor(Color, Dr, Dg, Db, Da);
end;

function RaisedColor(Color: TbsColor; Dx: smallint): TbsColor; overload;
begin
  Result := ChangeColor(Color, Dx);
end;

{ TbsBitmap ===================================================================}

constructor TbsBitmap.Create;
begin
  inherited Create;
  FDC := 0;
  with FBitmapInfo.bmiHeader do
  begin
    biSize := SizeOf(TBitmapInfoHeader);
    biPlanes := 1;
    biBitCount := 32;
    biCompression := BI_RGB;
  end;
end;

destructor TbsBitmap.Destroy;
begin
  RemoveBitmapFromList(Self);
  if FCanvas <> nil then
  begin
    FCanvas.Handle := 0;
    FreeAndNil(FCanvas);
  end;
  if FDC <> 0 then DeleteDC(FDC);
  FDC := 0;
  if FHandle <> 0 then DeleteObject(FHandle);
  FHandle := 0;
  FBits := nil;
  inherited Destroy;
end;

procedure TbsBitmap.AssignTo(Dest: TPersistent);
var
  Bmp: TBitmap;

  procedure CopyToBitmap(Bmp: TBitmap);
  begin
    Bmp.PixelFormat := pf32Bit;
    Bmp.Width := FWidth;
    Bmp.Height := FHeight;
    Draw(Bmp.Canvas, 0, 0);
  end;

begin
  if Dest is TPicture then CopyToBitmap(TPicture(Dest).Bitmap)
  else if Dest is TBitmap then CopyToBitmap(TBitmap(Dest))
  else if Dest is TClipboard then
  begin
    Bmp := TBitmap.Create;
    try
      CopyToBitmap(Bmp);
      TClipboard(Dest).Assign(Bmp);
    finally
      Bmp.Free;
    end;
  end
  else inherited;
end;

procedure TbsBitmap.Assign(Source: TPersistent);

  procedure AssignFromBitmap(SrcBmp: TBitmap);
  begin
    SetSize(SrcBmp.Width, SrcBmp.Height);
    if Empty then Exit;
    BitBlt(FDC, 0, 0, FWidth, FHeight, SrcBmp.Canvas.Handle, 0, 0, SRCCOPY);
    SetAlpha($FF);
  end;

var
  SLine: PbsColorArray;
  DstP: PbsColor;
  i, j: integer;
begin
  if Source is TbsBitmap then
  begin
    SetSize((Source as TbsBitmap).FWidth, (Source as TbsBitmap).FHeight);
    if Empty then Exit;
    MoveLongwordFunc((Source as TbsBitmap).Bits, FBits, FWidth * FHeight);
    { Assign properties }
    FName := (Source as TbsBitmap).FName;
    FTransparent := (Source as TbsBitmap).FTransparent;
    FAlphaBlend := (Source as TbsBitmap).FAlphaBlend;
  end
  else
    if Source is TBitmap then
    begin
      if ((Source as TBitmap).PixelFormat = pf32bit) and
         ((Source as TBitmap).HandleType = bmDIB) then
      with (Source as TBitmap) do
      begin
        { Alpha }
        Self.SetSize(Width, Height);
        { Copy alpha }
        for j := 0 to Height - 1 do
        begin
          SLine := Scanline[j];
          for i := 0 to Width - 1 do
          begin
            DstP := PixelPtr[i, j];
            DstP^ := SLine^[i];
          end;
        end;
        { CheckAlpha }
        CheckingAlphaBlend; 
      end
      else
      begin
        { Copy }
        AssignFromBitmap((Source as TBitmap));
        SetAlpha($FF);
      end;
    end
    else
      if Source is TGraphic then
      begin
        SetSize(TGraphic(Source).Width, TGraphic(Source).Height);
        if Empty then Exit;
        DrawGraphic(TGraphic(Source), Rect(0, 0, FWidth, FHeight));
        SetAlpha($FF);
      end
      else
        if Source is TPicture then
        begin
          with TPicture(Source) do
          begin
            if TPicture(Source).Graphic is TBitmap then
              AssignFromBitmap(TBitmap(TPicture(Source).Graphic))
            else
            begin
              // icons, metafiles etc...
              Self.SetSize(TPicture(Source).Graphic.Width, TPicture(Source).Graphic.Height);
              if Empty then Exit;
              DrawGraphic(TPicture(Source).Graphic, Rect(0, 0, FWidth, FHeight));
              SetAlpha($FF);
            end;
          end;
        end
        else  { inherited }
          inherited;
end;

procedure TbsBitmap.SetSize(AWidth, AHeight: Integer);
begin
    AWidth := Abs(AWidth);
    AHeight := Abs(AHeight);
    if (AWidth = 0) or (AHeight = 0) then Exit;
    if (AWidth = FWidth) and (AHeight = FHeight) then Exit;

    { Free resource }
    if FDC <> 0 then DeleteDC(FDC);
    FDC := 0;
    if FHandle <> 0 then DeleteObject(FHandle);
    FHandle := 0;
    FBits := nil;

    { Initialization }
    with FBitmapInfo.bmiHeader do
    begin
      biWidth := AWidth;
      biHeight := -AHeight;
    end;

    { Create new DIB }
    FHandle := CreateDIBSection(0, FBitmapInfo, DIB_RGB_COLORS, Pointer(FBits), 0, 0);
    if FBits = nil then
      raise Exception.Create('Can''t allocate the DIB handle');

    FDC := CreateCompatibleDC(0);
    if FDC = 0 then
    begin
      DeleteObject(FHandle);
      FHandle := 0;
      FBits := nil;
      raise Exception.Create('Can''t create compatible DC');
    end;

    if SelectObject(FDC, FHandle) = 0 then
    begin
      DeleteDC(FDC);
      DeleteObject(FHandle);
      FDC := 0;
      FHandle := 0;
      FBits := nil;
      raise Exception.Create('Can''t bslect an object into DC');
    end;

    { Add to BitmapList }
    AddBitmapToList(Self);
    if FCanvas <> nil then
      FCanvas.Handle := DC;

  FWidth := AWidth;
  FHeight := AHeight;
end;

function TbsBitmap.Empty: boolean;
begin
  Result := FHandle = 0;
end;

procedure TbsBitmap.Clear(Color: TbsColor);
begin
  FillLongwordFunc(Bits, FWidth * FHeight, Color);
end;

{ I/O Routines }

procedure TbsBitmap.LoadFromResource(const ResFileName, ResName: string);
var
  H: THandle;
  ResStream: TStream;
  BitmapInfo: PBitmapInfo;
  HeaderSize: integer;
  B: TBitmap;
  Bmp: HBitmap;
  HResInfo: HRSRC;
begin
  H := LoadLibraryEx(PChar(ResFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
  try
    HResInfo := FindResource(H, PChar(ResName), RT_BITMAP);
    if HResInfo <> 0 then
    begin
      ResStream := TResourceStream.Create(H, ResName, RT_BITMAP);
      try
        ResStream.Read(HeaderSize, sizeof(HeaderSize));
        GetMem(BitmapInfo, HeaderSize + 12 + 256 * sizeof(TRGBQuad));
        with BitmapInfo^ do
        try
          ResStream.Read(Pointer(Longint(BitmapInfo) + sizeof(HeaderSize))^,
            HeaderSize - sizeof(HeaderSize));

          B := TBitmap.Create;
          try
            if BitmapInfo^.bmiHeader.biBitCount = 32 then
              B.LoadFromResourceName(H, ResName) // By VCL
            else
            begin
              B.Handle := LoadBitmap(H, PChar(ResName)); // By Windows
              if B.Handle = 0 then
                B.LoadFromResourceName(H, ResName) // Try by VCL
            end;

            Assign(B);
          finally
            B.Free;
          end;
        finally
          FreeMem(BitmapInfo);
        end;
      finally
        ResStream.Free;
      end;
    end;
  finally
    FreeLibrary(H);
  end;
end;

procedure TbsBitmap.LoadFromStream(Stream: TStream);
var
  W, H: integer;
begin
  FName := ReadString(Stream);
  Stream.Read(W, SizeOf(Integer));
  Stream.Read(H, SizeOf(Integer));
  if (H > 0) then
  begin
    { New format since 3.4.4 }
    SetSize(W, H);
    if (FWidth = W) and (FHeight = H) then
      Stream.Read(FBits^, FWidth * FHeight * SizeOf(Longword));
  end
  else
  begin
    H := Abs(H);
    SetSize(W, H);
    if (FWidth = W) and (FHeight = H) then
      Stream.Read(FBits^, FWidth * FHeight * SizeOf(Longword));
    FlipVert;
  end;
  { Checking }
{  CheckingAlphaBlend;
  if not FAlphaBlend then CheckingTransparent;}
end;

procedure TbsBitmap.SaveToStream(Stream: TStream);
var
  NewFormatHeight: integer;
begin
  WriteString(Stream, FName);
  Stream.Write(FWidth, SizeOf(Integer));
  NewFormatHeight := FHeight; { New format since 3.4.4 }
  Stream.Write(NewFormatHeight, SizeOf(Integer));
  Stream.Write(FBits^, FWidth * FHeight * SizeOf(Longword));
end;

type

  TRGB = packed record
   R, G, B: Byte;
  end;

  TPCXHeader = record
    FileID: Byte;                      // $0A for PCX files, $CD for SCR files
    Version: Byte;                     // 0: version 2.5; 2: 2.8 with palette; 3: 2.8 w/o palette; 5: version 3
    Encoding: Byte;                    // 0: uncompressed; 1: RLE encoded
    BitsPerPixel: Byte;
    XMin,
    YMin,
    XMax,
    YMax,                              // coordinates of the corners of the image
    HRes,                              // horizontal resolution in dpi
    VRes: Word;                        // vertical resolution in dpi
    ColorMap: array[0..15] of TRGB;    // color table
    Reserved,
    ColorPlanes: Byte;                 // color planes (at most 4)
    BytesPerLine,                      // number of bytes of one line of one plane
    PaletteType: Word;                 // 1: color or b&w; 2: gray scale
    Fill: array[0..57] of Byte;
  end;

procedure TbsBitmap.LoadFromPcxStream(Stream: TStream);
const
  FSourceBPS: byte = 8;
  FTargetBPS: byte = 8;
var
  Header: TPCXHeader;
  Bitmap: TBitmap;

  procedure PcxDecode(var Source, Dest: Pointer; PackedSize, UnpackedSize: Integer);
  var
    Count: Integer;
    SourcePtr,
    TargetPtr: PByte;
  begin
    SourcePtr := Source;
    TargetPtr := Dest;
    while UnpackedSize > 0 do
    begin
      if (SourcePtr^ and $C0) = $C0 then
      begin
        // RLE-Code
        Count := SourcePtr^ and $3F;
        Inc(SourcePtr);
        if UnpackedSize < Count then Count := UnpackedSize;
        FillChar(TargetPtr^, Count, SourcePtr^);
        Inc(SourcePtr);
        Inc(TargetPtr, Count);
        Dec(UnpackedSize, Count);
      end
      else
      begin
        // not compressed
        TargetPtr^ := SourcePtr^;
        Inc(SourcePtr);
        Inc(TargetPtr);
        Dec(UnpackedSize);
      end;
    end;
  end;

  function PcxCreateColorPalette(Data: array of Pointer; ColorCount: Cardinal): HPALETTE;
  var
    I, MaxIn, MaxOut: Integer;
    LogPalette: TMaxLogPalette;
    RunR8: PByte;
  begin
    FillChar(LogPalette, SizeOf(LogPalette), 0);
    LogPalette.palVersion := $300;
    if ColorCount > 256 then
      LogPalette.palNumEntries := 256
    else
      LogPalette.palNumEntries := ColorCount;

    RunR8 := Data[0];

    for I := 0 to LogPalette.palNumEntries - 1 do
    begin
      LogPalette.palPalEntry[I].peRed := RunR8^;
      Inc(RunR8);
      LogPalette.palPalEntry[I].peGreen := RunR8^;
      Inc(RunR8);
      LogPalette.palPalEntry[I].peBlue := RunR8^; Inc(
      RunR8);
    end;

    MaxIn := (1 shl FSourceBPS) - 1;
    MaxOut := (1 shl FTargetBPS) - 1;
    if (FTargetBPS <= 8) and (MaxIn <> MaxOut) then
    begin
      MaxIn := (1 shl FSourceBPS) - 1;
      MaxOut := (1 shl FTargetBPS) - 1;
      if MaxIn < MaxOut then
      begin
        { palette is too small, enhance it }
        for I := MaxOut downto 0 do
        begin
          LogPalette.palPalEntry[I].peRed := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peRed;
          LogPalette.palPalEntry[I].peGreen := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peGreen;
          LogPalette.palPalEntry[I].peBlue := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peBlue;
        end;
      end
      else
      begin
        { palette contains too many entries, shorten it }
        for I := 0 to MaxOut do
        begin
          LogPalette.palPalEntry[I].peRed := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peRed;
          LogPalette.palPalEntry[I].peGreen := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peGreen;
          LogPalette.palPalEntry[I].peBlue := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peBlue;
        end;
      end;
      LogPalette.palNumEntries := MaxOut + 1;
    end;

    { finally create palette }
    Result := CreatePalette(PLogPalette(@LogPalette)^);
  end;
  
  procedure MakePalette;
  var
    PCXPalette: array[0..255] of TRGB;
    OldPos: Integer;
    Marker: Byte;
  begin
    if (Header.Version <> 3) or (Bitmap.PixelFormat = pf1Bit) and
       (Bitmap.PixelFormat = pf8Bit) then
    begin
      OldPos := Stream.Position;
      { 256 colors with 3 components plus one marker byte }
      Stream.Position := Stream.Size - 769;
      Stream.Read(Marker, 1);

      Stream.Read(PCXPalette[0], 768);
      Bitmap.Palette := PcxCreateColorPalette([@PCXPalette], 256);

      Stream.Position := OldPos;
    end
    else
      Bitmap.Palette := SystemPalette16;
  end;

  procedure RowConvertIndexed8(Source: array of Pointer; Target: Pointer; Count: Cardinal; Mask: Byte);
  var
    SourceRun, TargetRun: PByte;
  begin
    SourceRun := Source[0];
    TargetRun := Target;

    if (FSourceBPS = FTargetBPS) and (Mask = $FF) then
      Move(SourceRun^, TargetRun^, (Count * FSourceBPS + 7) div 8);
  end;

var
  PCXSize, Size: Cardinal;
  RawBuffer, DecodeBuffer: Pointer;
  Run: PByte;
  I: Integer;
  Line: PByte;
  Increment: Cardinal;
begin
  { Load from PCX - 8-bit indexed RLE compressed/uncompressed }
  Bitmap := TBitmap.Create;
  try
    Bitmap.Handle := 0;

    Stream.Read(Header, SizeOf(Header));
    PCXSize := Stream.Size - Stream.Position;
    with Header do
    begin
      if not (FileID in [$0A, $CD]) then Exit;

      Bitmap.PixelFormat := pf8bit;
      MakePalette;

      Bitmap.Width := XMax - XMin + 1;
      Bitmap.Height := YMax - YMin + 1;

      { adjust alignment of line }
      Increment := ColorPlanes * BytesPerLine;

      { Decompress }
      if Header.Encoding = 1 then
      begin
        { RLE }
        Size := Increment * Bitmap.Height;
        GetMem(DecodeBuffer, Size);
        GetMem(RawBuffer, PCXSize);
        try
          Stream.ReadBuffer(RawBuffer^, PCXSize);

          PcxDecode(RawBuffer, DecodeBuffer, PCXSize, Size);
        finally
          if Assigned(RawBuffer) then FreeMem(RawBuffer);
        end;
      end
      else
      begin
        GetMem(DecodeBuffer, PCXSize);
        Stream.ReadBuffer(DecodeBuffer^, PCXSize);
      end;

      try
        Run := DecodeBuffer;
        { PCX 8 bit Index }
        for I := 0 to Bitmap.Height - 1 do
        begin
          Line := Bitmap.ScanLine[I];
          RowConvertIndexed8([Run], Line, Bitmap.Width, $FF);
          Inc(Run, Increment);
        end;
      finally
        if Assigned(DecodeBuffer) then FreeMem(DecodeBuffer);
      end;
    end;

    { Assign to Self }
    Assign(Bitmap);
  finally
    Bitmap.Free;
  end;
end;

{ Checking routines }

const
  Quantity = 6;

procedure TbsBitmap.CheckRGBA;
var
  i: Cardinal;
  C: PbsColor;
begin
  if (FHeight = 0) or (FWidth = 0) then Exit;
  C := @FBits[0];
  for i := 0 to FWidth * FHeight - 1 do
  begin
    if TbsColorRec(C^).R > TbsColorRec(C^).A
    then
     TbsColorRec(C^).R := TbsColorRec(C^).A;
    if TbsColorRec(C^).G > TbsColorRec(C^).A
    then
      TbsColorRec(C^).G := TbsColorRec(C^).A;
    if TbsColorRec(C^).B > TbsColorRec(C^).A
    then
      TbsColorRec(C^).B := TbsColorRec(C^).A;
    Inc(C);
  end;
end;

procedure TbsBitmap.CheckRGBA2;
var
  i: Cardinal;
  C: PbsColor;
begin
  if (FHeight = 0) or (FWidth = 0) then Exit;
  C := @FBits[0];
  for i := 0 to FWidth * FHeight - 1 do
  begin
    TbsColorRec(C^).R := Round(TbsColorRec(C^).R * TbsColorRec(C^).A / 255);
    TbsColorRec(C^).G := Round(TbsColorRec(C^).G * TbsColorRec(C^).A / 255);
    TbsColorRec(C^).B := Round(TbsColorRec(C^).B * TbsColorRec(C^).A / 255);
    Inc(C);
  end;
end;

procedure TbsBitmap.CheckingAlphaBlend;
var
  i: Cardinal;
  C: PbsColor;
begin
  FAlphaBlend := false;

  C := @FBits[0];
  for i := 0 to FWidth * FHeight - 1 do
  begin
    if (TbsColorRec(C^).A > 0) and (TbsColorRec(C^).A < $FF) then
    begin
      FAlphaBlend := true;
      Break;
    end;

    Inc(C);
  end;
end;

procedure TbsBitmap.CheckingAlphaBlend(ARect: TRect);
var
  i, j: integer;
  C: PbsColor;
begin
  FAlphaBlend := false;

  for i := 0 to FWidth - 1 do
    for j := 0 to FHeight - 1 do
    begin
      C := PixelPtr[i, j];
      if (TbsColorRec(C^).A > 0) and (TbsColorRec(C^).A < $FF) then
      begin
        FAlphaBlend := true;
        Break;
      end;
    end;
end;

procedure TbsBitmap.CheckingTransparent(Color: TbsColor = bsTransparent);
var
  i: Cardinal;
  C: PbsColor;
begin
  FTransparent := false;

  C := @FBits[0];
  for i := 0 to FWidth * FHeight - 1 do
  begin
    if (Abs(TbsColorRec(C^).R - TbsColorRec(Color).R) < Quantity) and
       (Abs(TbsColorRec(C^).G - TbsColorRec(Color).G) < Quantity) and
       (Abs(TbsColorRec(C^).B - TbsColorRec(Color).B) < Quantity)
    then
    begin
      C^ := bsTransparent;
      FTransparent := true;
    end;

    Inc(C);
  end;
end;

procedure TbsBitmap.CheckingTransparent(ARect: TRect; Color: TbsColor = bsTransparent);
var
  i, j: integer;
  C: PbsColor;
begin
  FTransparent := false;

  for i := 0 to FWidth - 1 do
    for j := 0 to FHeight - 1 do
    begin
      C := PixelPtr[i, j];
      if (Abs(TbsColorRec(C^).R - TbsColorRec(Color).R) < Quantity) and
         (Abs(TbsColorRec(C^).G - TbsColorRec(Color).G) < Quantity) and
         (Abs(TbsColorRec(C^).B - TbsColorRec(Color).B) < Quantity)
      then
      begin
        C^ := bsTransparent;
        FTransparent := true;
      end;
    end;
end;

procedure TbsBitmap.SetAlpha(Alpha: byte);
begin
  if Empty then Exit;
  FillAlphaFunc(Bits, FWidth * FHeight, Alpha);
end;

procedure TbsBitmap.SetAlpha(Alpha: byte; Rect: TRect);
begin
  if RectWidth(Rect) = 0 then Exit;
  if RectHeight(Rect) = 0 then Exit;

  if Rect.Left < 0 then Rect.Left := 0;
  if Rect.Top < 0 then Rect.Top := 0;
  if Rect.Right > FWidth then Rect.Right := FWidth;
  if Rect.Bottom > FHeight then Rect.Bottom := FHeight;
  FillAlphaRectFunc(FBits, FWidth, FHeight, Rect.Left, Rect.Top, Rect.Right-1,
    Rect.Bottom - 1, Alpha);
end;

{ Access properties }

function TbsBitmap.GetScanLine(Y: Integer): PbsColorArray;
begin
  Result := @Bits[Y * FWidth];
end;

function TbsBitmap.GetPixelPtr(X, Y: Integer): PbsColor;
begin
  Result := @Bits[X + Y * FWidth];
end;

function TbsBitmap.GetPixel(X, Y: Integer): TbsColor;
begin
  if (FBits <> nil) and (X >= 0) and (Y >= 0) and (X < Width) and (Y < Height) then
    Result := PixelPtr[X, Y]^
  else
    Result := 0;
end;

procedure TbsBitmap.SetPixel(X, Y: Integer; Value: TbsColor);
begin
  if X < 0 then Exit;
  if Y < 0 then Exit;
  if X > Width then Exit;
  if Y > Height then Exit;

  if FBits <> nil then
    PixelPtr[X, Y]^ := Value;
end;

{ BitmapLink }

function TbsBitmap.GetBitmapLink(Rect: TRect): TbsBitmapLink;
begin
  Result := TbsBitmapLink.Create;
  Result.Image := Self;
  Result.Name := Name;
  Result.Rect := Rect;
end;

function TbsBitmap.GetBitmapLink(Rect: string): TbsBitmapLink;
begin
  Result := TbsBitmapLink.Create;
  Result.Image := Self;
  Result.Name := Name;
  Result.Rect := StringToRect(Rect);
end;

{ Color transition ============================================================}

procedure TbsBitmap.ChangeBitmapBrightness(DeltaBrightness: integer);
var
  i: Cardinal;
  Color: PbsColor;
  A: byte;
begin
  if DeltaBrightness = 0 then Exit;
  if FWidth * FHeight = 0 then Exit;

  for i := 0 to FWidth * FHeight - 1 do
  begin
    Color := @Bits[i];
    A := TbsColorRec(Color^).A;
    if (A = 0) then Continue;
    Color^ := ChangeBrightness(Color^, DeltaBrightness);
    Color^ := Color^ and not AlphaMask or (A shl 24);
  end;
end;

procedure TbsBitmap.SetBitmapHue(Hue: integer);
var
  i: Cardinal;
  Color: PbsColor;
  A: byte;
begin
  if FWidth * FHeight = 0 then Exit;

  for i := 0 to FWidth * FHeight - 1 do
  begin
    Color := @Bits[i];
    A := TbsColorRec(Color^).A;
    if (A = 0) then Continue;
    Color^ := SetHue(Color^, Hue);
    Color^ := Color^ and not AlphaMask or (A shl 24);
  end;
end;

procedure TbsBitmap.ChangeBitmapSat(DeltaSat: integer);
var
  i: Cardinal;
  Color: PbsColor;
  A: byte;
begin
  if DeltaSat = 0 then Exit;
  if FWidth * FHeight = 0 then Exit;

  for i := 0 to FWidth * FHeight - 1 do
  begin
    Color := @Bits[i];
    A := TbsColorRec(Color^).A;
    if (A = 0) then Continue;
    Color^ := ChangeSat(Color^, DeltaSat);
    Color^ := Color^ and not AlphaMask or (A shl 24);
  end;
end;

procedure TbsBitmap.ChangeBitmapHue(DeltaHue: integer);
var
  i: Cardinal;
  Color: PbsColor;
  A: byte;
begin
  if DeltaHue = 0 then Exit;
  if FWidth * FHeight = 0 then Exit;

  for i := 0 to FWidth * FHeight - 1 do
  begin
    Color := @Bits[i];
    A := TbsColorRec(Color^).A;
    if (A = 0) then Continue;
    Color^ := ChangeHue(Color^, DeltaHue);
    Color^ := Color^ and not AlphaMask or (A shl 24);
  end;
end;

{ Draw to XXX =================================================================}

procedure TbsBitmap.Draw(DC: HDC; X, Y: integer);
begin
  Draw(DC, X, Y, Rect(0, 0, Width, Height));
end;

procedure TbsBitmap.Draw(DC: HDC; X, Y: integer; SrcRect: TRect);
begin
  Draw(DC, Rect(X, Y, X + RectWidth(SrcRect), Y + RectHeight(SrcRect)), SrcRect);
end;

procedure TbsBitmap.Draw(DC: HDC; DstRect: TRect);
begin
  Draw(DC, DstRect, Rect(0, 0, FWidth, FHeight));
end;

procedure TbsBitmap.Draw(DC: HDC; DstRect, SrcRect: TRect);
var
  Dst: TbsBitmap;
  P: TPoint;
  BitmapW, BitmapH, BitmapBCount: integer;
  BitmapBits: PByteArray;
begin
  Dst := FindBitmapByDC(DC);
  if Dst <> nil then
  begin
    { Adjust WindowOrg }
    GetWindowOrgEx(DC, P);
    OffsetRect(DstRect, -P.X, -P.Y);
    { Destination is KS Bitmap }
    Draw(Dst, DstRect, SrcRect);
  end
  else
  begin
(*    BitmapBits := GetBitsFromDCFunc(DC, BitmapW, BitmapH, BitmapBCount);
    if EnableDibOperation and (BitmapBits <> nil) and (BitmapBCount = 32) and (BitmapH > 0) then
    begin
      { Adjust WindowOrg }
      GetWindowOrgEx(DC, P);
      OffsetRect(DstRect, -P.X, -P.Y);
      { Draw to DIB }
      if FAlphaBlend then
        StretchToDibAlphaBlendFunc(BitmapBits, DstRect, DstRect, BitmapW, BitmapH,
          Self, SrcRect)
      else
        if FTransparent then
          StretchToDibTransparentFunc(BitmapBits, DstRect, DstRect, BitmapW, BitmapH,
            Self, SrcRect)
        else
          StretchToDibOpaqueFunc(BitmapBits, DstRect, DstRect, BitmapW, BitmapH,
            Self, SrcRect);
    end
    else *)
    begin
      { Draw to DC }
      if FAlphaBlend then
        StretchToDCAlphaBlendFunc(DC, DstRect.Left, DstRect.Top, RectWidth(DstRect), RectHeight(DstRect),
          Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect))
      else
        if FTransparent then
          StretchToDCTransparentFunc(DC, DstRect.Left, DstRect.Top, RectWidth(DstRect), RectHeight(DstRect),
            Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect))
        else
          StretchToDCOpaqueFunc(DC, DstRect.Left, DstRect.Top, RectWidth(DstRect), RectHeight(DstRect),
            Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect));
    end;
  end;
end;

procedure TbsBitmap.Draw(Canvas: TCanvas; X, Y: integer);
begin
  Draw(Canvas.Handle, X, Y);
end;

procedure TbsBitmap.Draw(Canvas: TCanvas; X, Y: integer; SrcRect: TRect);
begin
  Draw(Canvas, Rect(X, Y, X + RectWidth(SrcRect), Y + RectHeight(SrcRect)), SrcRect);
end;

procedure TbsBitmap.Draw(Canvas: TCanvas; DstRect: TRect);
begin
  Draw(Canvas, DstRect, Rect(0, 0, FWidth, FHeight));
end;

procedure TbsBitmap.Draw(Canvas: TCanvas; DstRect, SrcRect: TRect);
begin
  Draw(Canvas.Handle, DstRect, SrcRect);
end;

procedure TbsBitmap.Draw(Bitmap: TbsBitmap; X, Y: integer);
begin
  Draw(Bitmap, X, Y, Rect(0, 0, Width, Height));
end;

procedure TbsBitmap.Draw(Bitmap: TbsBitmap; X, Y: integer;
  SrcRect: TRect);
begin
  Draw(Bitmap, Rect(X, Y, X + RectWidth(SrcRect), Y + RectHeight(SrcRect)), SrcRect);
end;

procedure TbsBitmap.Draw(Bitmap: TbsBitmap; DstRect: TRect);
begin
  Draw(Bitmap, DstRect, Rect(0, 0, FWidth, FHeight));
end;

procedure TbsBitmap.Draw(Bitmap: TbsBitmap; DstRect, SrcRect: TRect);
begin
  if AlphaBlend then
    StretchAlphaBlendFunc(Bitmap, DstRect, DstRect, Self, SrcRect)
  else
    if Transparent then
      StretchTransparentFunc(Bitmap, DstRect, DstRect, Self, SrcRect)
    else
      StretchOpaqueFunc(Bitmap, DstRect, DstRect, Self, SrcRect)
end;

procedure TbsBitmap.Tile(DC: HDC; DstRect, SrcRect: TRect);
var
  i, j: integer;
  R, R1, SrcR: TRect;
  Cx, Cy: integer;
  W, H, DW, DH: integer;
  Dst: TbsBitmap;
  BitmapW, BitmapH, BitmapBCount: integer;
  BitmapBits: PByteArray;

  procedure Draw( SrcRect: TRect);
  var
    P: TPoint;
  begin
    if Dst <> nil then
    begin
      { Adjust WindowOrg }
      GetWindowOrgEx(DC, P);
      OffsetRect(R, -P.X, -P.Y);
      { Destination is KS Bitmap }
      Self.Draw(Dst, R, SrcRect);
    end
    else
    begin
      if EnableDibOperation and (BitmapBits <> nil) and (BitmapBCount = 32) and (BitmapH > 0) then
      begin
        { Adjust WindowOrg }
        GetWindowOrgEx(DC, P);
        OffsetRect(R, -P.X, -P.Y);
        { Draw to DIB }
        if FAlphaBlend then
          StretchToDibAlphaBlendFunc(BitmapBits, R, R, BitmapW, BitmapH,
            Self, SrcRect)
        else
          if FTransparent then
            StretchToDibTransparentFunc(BitmapBits, R, R, BitmapW, BitmapH,
              Self, SrcRect)
          else
            StretchToDibOpaqueFunc(BitmapBits, R, R, BitmapW, BitmapH,
              Self, SrcRect);
      end
      else
      begin
        { Draw to DC }
        if FAlphaBlend then
          StretchToDCAlphaBlendFunc(DC, R.Left, R.Top, RectWidth(R), RectHeight(R),
            Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect))
        else
          if FTransparent then
            StretchToDCTransparentFunc(DC, R.Left, R.Top, RectWidth(R), RectHeight(R),
              Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect))
          else
            StretchToDCOpaqueFunc(DC, R.Left, R.Top, RectWidth(R), RectHeight(R),
              Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect));
      end;
    end;
  end;

begin
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  if (W=0) or (H=0) then Exit;

  Dst := FindBitmapByDC(DC);
  if Dst=nil then
    BitmapBits := GetBitsFromDCFunc(DC, BitmapW, BitmapH, BitmapBCount);

  SrcR := Rect(0, 0, W, H);
  OffsetRect(SrcR, DstRect.Left, DstRect.Top);

  Cx := RectWidth(DstRect) div W;
  if RectWidth(DstRect) mod W <> 0 then Inc(Cx);
  Cy := RectHeight(DstRect) div H;
  if RectHeight(DstRect) mod H <> 0 then Inc(Cy);

  for i := 0 to Cx do
    for j := 0 to Cy do
    begin
      R := SrcR;
      OffsetRect(R, i * W, j * H);

      IntersectRect(R, R, DstRect);

      DW := RectWidth(R);
      DH := RectHeight(R);

      if (DW = 0) or (DH = 0) then Break;

      R1 := SrcRect;
      if (DW <> W) or (DH <> H) then
      begin
        R1.Right := R1.Left + DW;
        R1.Bottom := R1.Top + DH;
        Draw( R1);
      end
      else
        Draw( R1);
    end;
end;

procedure TbsBitmap.Tile(Canvas: TCanvas; DstRect, SrcRect: TRect);
begin
  Tile(Canvas.Handle, DstRect, SrcRect);
end;

procedure TbsBitmap.Tile(Bitmap: TbsBitmap; DstRect, SrcRect: TRect);
var
  i, j: integer;
  R, R1, SrcR: TRect;
  Cx, Cy: integer;
  W, H, DW, DH: integer;
begin
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  if W * H = 0 then Exit;

  SrcR := Rect(0, 0, W, H);
  OffsetRect(SrcR, DstRect.Left, DstRect.Top);

  Cx := RectWidth(DstRect) div W;
  if RectWidth(DstRect) mod W <> 0 then Inc(Cx);
  Cy := RectHeight(DstRect) div H;
  if RectHeight(DstRect) mod H <> 0 then Inc(Cy);

  for i := 0 to Cx do
    for j := 0 to Cy do
    begin
      R := SrcR;
      OffsetRect(R, i * W, j * H);

      IntersectRect(R, R, DstRect);

      DW := RectWidth(R);
      DH := RectHeight(R);

      if (DW = 0) or (DH = 0) then Break;

      if (DW <> W) or (DH <> H) then
      begin
        R1 := SrcRect;
        R1.Right := R1.Left + DW;
        R1.Bottom := R1.Top + DH;
        Draw(Bitmap, R, R1);
      end
      else
        Draw(Bitmap, R, SrcRect);
    end;
end;

procedure TbsBitmap.TileClip(DC: HDC; DstRect, DstClip, SrcRect: TRect);
var
  i, j: integer;
  R, R1, SrcR, ClipRes: TRect;
  Cx, Cy: integer;
  W, H, DW, DH: integer;
  IsClip: boolean;
begin
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  if W * H = 0 then Exit;

  if IsRectEmpty(DstClip) then
    IsClip := false
  else
    IsClip := true;
  SrcR := Rect(0, 0, W, H);
  OffsetRect(SrcR, DstRect.Left, DstRect.Top);

  Cx := RectWidth(DstRect) div W;
  if RectWidth(DstRect) mod W <> 0 then Inc(Cx);
  Cy := RectHeight(DstRect) div H;
  if RectHeight(DstRect) mod H <> 0 then Inc(Cy);

  for i := 0 to Cx do
    for j := 0 to Cy do
    begin
      R := SrcR;
      OffsetRect(R, i * W, j * H);

      IntersectRect(R, R, DstRect);

      DW := RectWidth(R);
      DH := RectHeight(R);

      if (DW = 0) or (DH = 0) then Break;

      if (DW <> W) or (DH <> H) then
      begin
        R1 := SrcRect;
        R1.Right := R1.Left + DW;
        R1.Bottom := R1.Top + DH;
        if IsClip then
        begin
          if IntersectRect(ClipRes, DstClip, R) then
            Draw(DC, R, R1);
        end
        else
          Draw(DC, R, R1);
      end
      else
        if IsClip then
        begin
          if IntersectRect(ClipRes, DstClip, R) then
            Draw(DC, R, SrcRect);
        end
        else
          Draw(DC, R, SrcRect);
    end;
end;

procedure TbsBitmap.TileClip(Canvas: TCanvas; DstRect, DstClip, SrcRect: TRect);
begin
  TileClip(Canvas.Handle, DstRect, DstClip, SrcRect);
end;

procedure TbsBitmap.TileClip(Bitmap: TbsBitmap; DstRect, DstClip, SrcRect: TRect);
var
  i, j: integer;
  R, R1, ClipRes, SrcR: TRect;
  Cx, Cy: integer;
  W, H, DW, DH: integer;
  IsClip: boolean;
begin
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  if W * H = 0 then Exit;

  SrcR := Rect(0, 0, W, H);
  OffsetRect(SrcR, DstRect.Left, DstRect.Top);

  if IsRectEmpty(DstClip) then
    IsClip := false
  else
    IsClip := true;

  Cx := RectWidth(DstRect) div W;
  if RectWidth(DstRect) mod W <> 0 then Inc(Cx);
  Cy := RectHeight(DstRect) div H;
  if RectHeight(DstRect) mod H <> 0 then Inc(Cy);

  for i := 0 to Cx do
    for j := 0 to Cy do
    begin
      R := SrcR;
      OffsetRect(R, i * W, j * H);

      IntersectRect(R, R, DstRect);

      DW := RectWidth(R);
      DH := RectHeight(R);

      if (DW = 0) or (DH = 0) then Break;

      if (DW <> W) or (DH <> H) then
      begin
        R1 := SrcRect;
        R1.Right := R1.Left + DW;
        R1.Bottom := R1.Top + DH;
        if IsClip then
        begin
          if IntersectRect(ClipRes, DstClip, R) then
            Draw(Bitmap, R, R1);
        end
        else
          Draw(Bitmap, R, R1);
      end
      else
        if IsClip then
        begin
          if IntersectRect(ClipRes, DstClip, R) then
            Draw(Bitmap, R, SrcRect);
        end
        else
          Draw(Bitmap, R, SrcRect);
    end;
end;

procedure TbsBitmap.MergeDraw(Bitmap: TbsBitmap; X, Y: integer; SrcRect: TRect);
var
  Index: integer;
  i, j: integer;
  B, F: PbsColor;
  Alpha: byte;
begin
  if SrcRect.Left < 0 then
  begin
    X := X + Abs(SrcRect.Left);
    SrcRect.Left := 0;
  end;
  if SrcRect.Top < 0 then
  begin
    Y := Y + Abs(SrcRect.Top);
    SrcRect.Top := 0;
  end;
  if SrcRect.Right > Bitmap.FWidth then SrcRect.Right := Bitmap.FWidth;
  if SrcRect.Bottom > Bitmap.FHeight then SrcRect.Bottom := Bitmap.FHeight;
  { Draw bitmap rect to another bitmap }
  try
    for i := SrcRect.Left to SrcRect.Right-1 do
      for j := SrcRect.Top to SrcRect.Bottom-1 do
      begin
        { Get Back pixel from Bitmap }
        B := Bitmap.PixelPtr[i, j];
        { Get fore pixel }
        Index := (X + i-SrcRect.Left) + (Y + (j-SrcRect.Top)) * FWidth;
        if Index >= FWidth * FHeight then Continue;
        F := @FBits[Index];

        { Blend }
        Alpha := F^ shr 24;
        if Alpha = 0 then
          F^ := B^
        else
          if Alpha < $FF then
            F^ := PixelAlphaBlendFunc(F^, B^);
      end;
  finally
    EMMS;
  end;
end;

{ Painting Routines ===========================================================}

procedure TbsBitmap.DrawGraphic(Graphic: TGraphic; DstRect: TRect);
var
  Bitmap: TBitmap;
  SL: PbsColorArray;
  i, j: integer;
begin
  { Create DIB copy }
  Bitmap := TBitmap.Create;
  try
    Bitmap.PixelFormat := pf32bit;
    Bitmap.Width := FWidth;
    Bitmap.Height := FHeight;
    Bitmap.Canvas.Brush.Color := RGB(255, 0, 255);
    Bitmap.Canvas.Rectangle(-1, -1, FWidth + 1, FHeight + 1);
    Bitmap.Canvas.StretchDraw(DstRect, Graphic);

    { Copy to bitmap }
    for j := 0 to FHeight - 1 do
    begin
      SL := Bitmap.Scanline[j];
      for i := 0 to FWidth - 1 do
        if (TbsColorRec(SL[i]).R = $FF) and (TbsColorRec(SL[i]).G = 0) and (TbsColorRec(SL[i]).B = $FF) then
          Continue
        else
          Pixels[i, j] := SL[i];
    end;
  finally
    Bitmap.Free;
  end;
end;

procedure TbsBitmap.DrawBevel(R: TRect; Color: TbsColor; Width: integer;
  Down: boolean);
begin

end;

procedure TbsBitmap.DrawEdge(R: TRect; RaisedColor,
  SunkenColor: TbsColor);
begin

end;

procedure TbsBitmap.DrawEllipse(R: TRect; Color: TbsColor);
begin

end;

procedure TbsBitmap.DrawFocusRect(R: TRect; Color: TbsColor);
begin

end;

procedure TbsBitmap.DrawLine(R: TRect; Color: TbsColor);
begin

end;

procedure TbsBitmap.DrawPolygon(Points: array of TPoint; Color: TColor);
begin

end;

procedure TbsBitmap.DrawRect(R: TRect; Color: TbsColor);
begin

end;

procedure TbsBitmap.DrawRoundRect(R: TRect; Radius: integer;
  Color: TbsColor);
begin

end;

function TbsBitmap.DrawText(AText: WideString; var Bounds: TRect;
  Flag: cardinal): integer;
begin
  Result := 0;
end;

function TbsBitmap.DrawText(AText: WideString; X, Y: integer): integer;
begin
  Result := 0;
end;

function TbsBitmap.DrawVerticalText(AText: WideString; Bounds: TRect;
  Flag: cardinal; FromTop: boolean): integer;
begin
  Result := 0;
end;

procedure TbsBitmap.FillEllipse(R: TRect; Color: TbsColor);
begin

end;

procedure TbsBitmap.FillGradientRect(Rect: TRect; BeginColor,
  EndColor: TbsColor; Vertical: boolean);
begin

end;

procedure TbsBitmap.FillHalftonePolygon(Points: array of TPoint; Color,
  HalfColor: TbsColor);
begin

end;

procedure TbsBitmap.FillHalftoneRect(R: TRect; Color,
  HalfColor: TbsColor);
begin

end;

procedure TbsBitmap.FillPolygon(Points: array of TPoint; Color: TColor);
begin

end;

procedure TbsBitmap.FillRadialGradientRect(Rect: TRect; BeginColor,
  EndColor: TbsColor; Pos: TPoint);
begin

end;

procedure TbsBitmap.FillRect(R: TRect; Color: TbsColor);
var
  Size, j: integer;
  AlphaLine: PbsColor;
begin
  if R.Left < 0 then R.Left := 0;
  if R.Top < 0 then R.Top := 0;
  if R.Right > Width then R.Right := Width;
  if R.Bottom > Height then R.Bottom := Height;
  if RectWidth(R) <= 0 then Exit;
  if RectHeight(R) <= 0 then Exit;

  if AlphaBlend then
  begin
    Size := RectWidth(R);
    GetMem(AlphaLine, SizeOf(TbsColor) * Size);
    try
      FillLongwordFunc(AlphaLine, Size, Color);
      for j := R.Top to R.Bottom-1 do
        LineAlphaBlendFunc(AlphaLine, PixelPtr[R.Left, j], Size);
    finally
      FreeMem(AlphaLine, SizeOf(TbsColor) * Size);
      EMMS;
    end;
  end
  else
    FillLongwordRectFunc(FBits, FWidth, FHeight, R.Left, R.Top, R.Right-1, R.Bottom - 1, Color);
end;

procedure TbsBitmap.FillRoundRect(R: TRect; Radius: integer;
  Color: TbsColor);
begin

end;

procedure TbsBitmap.LineTo(X, Y: integer; Color: TbsColor);
begin

end;

procedure TbsBitmap.MoveTo(X, Y: integer);
begin

end;

function TbsBitmap.TextHeight(AText: WideString): integer;
begin
  Result := 0;
end;

function TbsBitmap.TextWidth(AText: WideString; Flags: Integer): integer;
begin
  Result := 0;
end;

procedure TbsBitmap.Reflection3;
var
  SLine: PbsColorArray;
  i, j: Integer;
  AlphaValue: Integer;
  kf, step: Double;
begin
  FlipVert;
  step := (1 / Height) *  2;
  kf := 1;
  for j := 0 to Height - 1 do
   begin
     SLine := Scanline[j];
     for i := 0 to Width - 1 do
     begin
       if TbsColorRec(SLine^[i]).A <> 0
       then
         begin
           AlphaValue := Round(TbsColorRec(SLine^[i]).A * kf) div 2;
           if AlphaValue < 0 then AlphaValue := 0;
           TbsColorRec(SLine^[i]).A := AlphaValue;
         end;
     end;
    kf := kf - Step;
  end;
end;

procedure TbsBitmap.Reflection;
var
  SLine: PbsColorArray;
  i, j: Integer;
  AlphaValue: Integer;
  kf, step: Double;
begin
  FlipVert;
  step := (1 / Height) *  2;
  kf := 1;
  for j := 0 to Height - 1 do
   begin
     SLine := Scanline[j];
     for i := 0 to Width - 1 do
     begin
       if TbsColorRec(SLine^[i]).A <> 0
       then
         begin
           AlphaValue := Round(TbsColorRec(SLine^[i]).A * kf) div 3;
           if AlphaValue < 0 then AlphaValue := 0;
           TbsColorRec(SLine^[i]).A := AlphaValue;
         end;
     end;
    kf := kf - Step;
  end;
end;

procedure TbsBitmap.Reflection2;
var
  SLine: PbsColorArray;
  i, j: Integer;
  AlphaValue: Integer;
  kf, step: Double;
begin
  FlipVert;
  step := (1 / Height) *  2;
  kf := 1;
  for j := 0 to Height - 1 do
   begin
     SLine := Scanline[j];
     for i := 0 to Width - 1 do
     begin
       if TbsColorRec(SLine^[i]).A <> 0
       then
         begin
           AlphaValue := Round(TbsColorRec(SLine^[i]).A * kf) div 4;
           if AlphaValue < 0 then AlphaValue := 0;
           TbsColorRec(SLine^[i]).A := AlphaValue;
         end;
     end;
    kf := kf - Step;
  end;
end;

procedure TbsBitmap.FlipVert;
var
 J, J2: Integer;
 Buffer: PbsColorArray;
 P1, P2: PbsColor;
begin
   J2 := Height - 1;
   GetMem(Buffer, Width shl 2);
   for J := 0 to Height div 2 - 1 do
   begin
     P1 := PixelPtr[0, J];
     P2 := PixelPtr[0, J2];
     MoveLongwordFunc(P1, PbsColor(Buffer), Width);
     MoveLongwordFunc(P2, P1, Width);
     MoveLongwordFunc(PbsColor(Buffer), P2, Width);
     Dec(J2);
   end;
   FreeMem(Buffer);
end;

{ TbsBitmapLink ================================================================}

constructor TbsBitmapLink.Create;
begin
  inherited Create;
end;

destructor TbsBitmapLink.Destroy;
begin
  inherited Destroy;
end;

procedure TbsBitmapLink.Assign(Source: TPersistent);
begin
  if Source is TbsBitmapLink then
  begin
    FImage := (Source as TbsBitmapLink).FImage;
    FRect := (Source as TbsBitmapLink).FRect;
    FName := (Source as TbsBitmapLink).FName;
    FMasked := (Source as TbsBitmapLink).FMasked;
    FMaskedBorder := (Source as TbsBitmapLink).FMaskedBorder;
    FMaskedAngles := (Source as TbsBitmapLink).FMaskedAngles;
  end
  else
    inherited;
end;

procedure TbsBitmapLink.LoadFromStream(Stream: TStream);
begin
  FName := ReadString(Stream);
  Stream.Read(FRect, SizeOf(FRect));
end;

procedure TbsBitmapLink.SaveToStream(Stream: TStream);
begin
  WriteString(Stream, FName);
  Stream.Write(FRect, SizeOf(FRect));
end;

procedure TbsBitmapLink.CheckingMasked(Margin: TRect);
var
  i, j: integer;
  P: TbsColor;
  Pt: TPoint;
begin
  FMasked := false;
  FMaskedBorder := false;
  FMaskedAngles := false;

  if (Margin.Left = 0) and (Margin.Top = 0) and (Margin.Right = 0) and (Margin.Right = 0) then
  begin
    for i := Left to Right - 1 do
      for j := Top to Bottom - 1 do
      begin
        if (FImage.Bits <> nil) and (i >= 0) and (j >= 0) and (i < FImage.Width) and (j < FImage.Height) then
          P := PbsColor(@FImage.Bits[i + j * FImage.Width])^
        else
          P := 0;

        if P <> cbsNone then
        begin
          if P = bsTransparent then
          begin
            FMasked := true;
            Break;
          end;
          if TbsColorRec(P).A < $FF then
          begin
            FMasked := true;
            Break;
          end;
        end;
      end;
  end
  else
  begin
    for i := Left to Right - 1 do
      for j := Top to Bottom - 1 do
      begin
        if (FImage.Bits <> nil) and (i >= 0) and (j >= 0) and (i < FImage.Width) and (j < FImage.Height) then
          P := PbsColor(@FImage.Bits[i + j * FImage.Width])^
        else
          P := 0;

        if P <> cbsNone then
        begin
          if (P = bsTransparent) or (TbsColorRec(P).A < $FF) then
          begin
            Pt := Point(i - Left, j - Top);
            { Check angles }
            if PtInRect(Classes.Rect(0, 0, Margin.Left, Margin.Top), Pt) then
              FMaskedAngles := true;
            if PtInRect(Classes.Rect(Right - Margin.Right, 0, Right, Margin.Top), Pt) then
              FMaskedAngles := true;
            if PtInRect(Classes.Rect(Right - Margin.Right, Bottom - Margin.Bottom, Right, Bottom), Pt) then
              FMaskedAngles := true;
            if PtInRect(Classes.Rect(0, Bottom - Margin.Bottom, Margin.Left, Bottom), Pt) then
              FMaskedAngles := true;

            { Check borders }
            if PtInRect(Classes.Rect(Margin.Left, 0, Right - Margin.Right, Margin.Top), Pt) then
              FMaskedBorder := true;
            if PtInRect(Classes.Rect(Margin.Left, Bottom - Margin.Bottom, Right - Margin.Right, Bottom), Pt) then
              FMaskedBorder := true;
            if PtInRect(Classes.Rect(0, Margin.Top, Margin.Left, Bottom - Margin.Bottom), Pt) then
              FMaskedBorder := true;
            if PtInRect(Classes.Rect(Right - Margin.Right, Margin.Top, Right, Bottom - Margin.Bottom), Pt) then
              FMaskedBorder := true;

            if PtInRect(Classes.Rect(Margin.Left, Margin.Top, Right - Margin.Right, Bottom - Margin.Bottom), Pt) then
              FMasked := true;
          end;
        end;
      end;
  end;
end;

procedure TbsBitmapLink.CheckingMasked;
begin
  CheckingMasked(Classes.Rect(0, 0, 0, 0));
end;

procedure TbsBitmapLink.Draw(Bitmap: TbsBitmap; X, Y: integer);
begin
  if FImage = nil then Exit;
  if FImage.Empty then Exit;
  if FRect.Right - FRect.Left <= 0 then Exit;
  if FRect.Bottom - FRect.Top <= 0 then Exit;
  { Draw bitmap link }
  FImage.Draw(Image, X, Y, FRect);
end;

procedure TbsBitmapLink.Draw(Canvas: TCanvas; X, Y: integer);
begin
  if FImage = nil then Exit;
  if FImage.Empty then Exit;
  if FRect.Right - FRect.Left <= 0 then Exit;
  if FRect.Bottom - FRect.Top <= 0 then Exit;
  { Draw bitmap link }
  FImage.Draw(Canvas, X, Y, FRect);
end;

function TbsBitmapLink.GetAssigned: boolean;
begin
  Result := (FImage <> nil) and ((FRect.Right - FRect.Left) * (FRect.Bottom - FRect.Top) > 0);
end;

function TbsBitmapLink.GetBottom: integer;
begin
  Result := FRect.Bottom;
end;

function TbsBitmapLink.GetLeft: integer;
begin
  Result := FRect.Left;
end;

function TbsBitmapLink.GetRight: integer;
begin
  Result := FRect.Right;
end;

function TbsBitmapLink.GetTop: integer;
begin
  Result := FRect.Top;
end;

procedure TbsBitmapLink.SetBottom(const Value: integer);
begin
  FRect.Bottom := Value;
end;

procedure TbsBitmapLink.SetLeft(const Value: integer);
begin
  FRect.Left := Value;
end;

procedure TbsBitmapLink.SetRight(const Value: integer);
begin
  FRect.Right := Value;
end;

procedure TbsBitmapLink.SetTop(const Value: integer);
begin
  FRect.Top := Value;
end;

{ TbsBitmapList ===============================================================}

constructor TbsBitmapList.Create;
begin
  inherited Create;
end;

destructor TbsBitmapList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TbsBitmapList.Clear;
var
  i: integer;
begin
  for i := 0 to Count-1 do
    TbsBitmap(Items[i]).Free;
  inherited Clear;
end;

function TbsBitmapList.GetImage(index: integer): TbsBitmap;
begin
  if (index >= 0) and (index < Count) then
    Result := TbsBitmap(Items[index])
  else
    Result := nil;
end;

function TbsBitmapList.GetBitmapLink(Image: TbsBitmap; Rect: TRect): TbsBitmapLink;
var
  i: integer;
begin
  Result := nil;

  { Create BitmapLink }
  for i := 0 to Count - 1 do
    if Bitmaps[i] = Image then
    begin
      Result := Bitmaps[i].GetBitmapLink(Rect);
      Exit;
    end;
end;

function TbsBitmapList.GetBitmapLink(Name: string; Rect: TRect): TbsBitmapLink;
var
  i: integer;
begin
  Result := nil;

  { Create BitmapLink }
  for i := 0 to Count - 1 do
    if CompareText(Bitmaps[i].Name, Name) = 0 then
    begin
      Result := Bitmaps[i].GetBitmapLink(Rect);
      Exit;
    end;
end;

function TbsBitmapList.GetBitmapLink(Name, Rect: string): TbsBitmapLink;
var
  i: integer;
begin
  Result := nil;

  { Create BitmapLink }
  for i := 0 to Count - 1 do
    if CompareText(Bitmaps[i].Name, Name) = 0 then
    begin
      Result := Bitmaps[i].GetBitmapLink(Rect);
      Exit;
    end;
end;

function TbsBitmapList.GetBitmapByName(index: string): TbsBitmap;
var
  i: integer;
begin
  Result := nil;

  for i := 0 to Count - 1 do
    if CompareText(Bitmaps[i].Name, index) = 0 then
    begin
      Result := Bitmaps[i];
      Exit;
    end;
end;

function TbsBitmap.GetCanvas: TCanvas;
begin
  if FCanvas = nil then
  begin
    FCanvas := TCanvas.Create;
    FCanvas.Handle := DC;
  end;
  Result := FCanvas;
end;



{ Low-Level routines }

function FromRGB(Color: longword): longword;
{ TColor -> TbsColor }
asm
  BSWAP   EAX
  MOV     AL, $FF
  ROR     EAX,8
end;

function ToRGB(Color32: longword): longword;
{ TbsColor -> TColor }
asm
  ROL    EAX,8
  XOR    AL,AL
  BSWAP  EAX
end;

function MulDiv16(Number, Numerator, Denominator: Word): Word;
asm
  MUL DX
  DIV CX
end;

{ Non-MMX }

procedure _MoveLongword(const Src: Pointer; Dst: Pointer; Count: Integer);
asm
  PUSH    ESI
  PUSH    EDI

  MOV     ESI,EAX
  MOV     EDI,EDX
  MOV     EAX,ECX
  CMP     EDI,ESI
  JE      @exit

  REP     MOVSD
@exit:
  POP     EDI
  POP     ESI
end;

procedure _ClearAlpha(Src: Pointer; Count: integer; Value: longword);
asm
  { Clear alpha }
  PUSH   EDI

  MOV     EDI, EAX {X}
  MOV     EAX, ECX {Value}
  MOV     ECX, EDX {Count}
  TEST    ECX,ECX
  JS      @exit
  AND     EAX, $00FFFFFF
@1:
  MOV     EDX, [EDI]
  AND     EDX, $00FFFFFF
  CMP     EDX, EAX
  JNE     @2
  MOV     [EDI], EDX
@2:
  ADD     EDI, 4

  LOOP    @1

@exit:
  POP     EDI
end;

procedure _FillLongword(Src: Pointer; Count: Integer; Value: Longword);
asm
  PUSH    EDI

  MOV     EDI,EAX  // Point EDI to destination
  MOV     EAX,ECX
  MOV     ECX,EDX
  TEST    ECX,ECX
  JS      @exit

  REP     STOSD    // Fill count dwords
@exit:
  POP     EDI
end;

procedure _FillLongwordRect(Src: Pointer; W, H, X1, Y1, X2, Y2: Integer; Value: Longword);
asm
  PUSH    EDI
  PUSH    EAX
  PUSH    EBX
  PUSH    ECX
  PUSH    EDX

  MOV     EDI, EAX
  XOR     EBX, EBX
  XOR     EAX, EAX
  MOV     EBX, W
  MOV     EAX, Y1
  MUL     EBX
  ADD     EAX, X1
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX

  MOV     EBX, X2
  SUB     EBX, X1
  INC     EBX
  TEST    EBX,EBX
  JS      @exit

  MOV     EDX, Y2
  SUB     EDX, Y1
  INC     EDX
  TEST    EDX,EDX
  JS      @exit
  MOV     EAX, VALUE

@1:
  PUSH    EDI
  MOV     ECX, EBX
  CLD
  REP     STOSD
  POP     EDI
  POP     ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  PUSH    ECX
  DEC     EDX
  CMP     EDX, 0
  JNE     @1

@exit:
  POP     EDX
  POP     ECX
  POP     EBX
  POP     EAX
  POP     EDI
end;

procedure _FillAlpha(Src: Pointer; Count: Integer; Alpha: byte);
asm
  PUSH    EDI

  MOV     EDI,EAX  // Point EDI to destination
  MOV     AL, CL
  MOV     ECX,EDX
  TEST    ECX,ECX
  JS      @exit

@1:
  INC     EDI
  INC     EDI
  INC     EDI
  MOV     [EDI], AL
  INC     EDI
  LOOP    @1

@exit:
  POP     EDI
end;

procedure _FillAlphaRect(Src: Pointer; W, H, X1, Y1, X2, Y2: Integer; Alpha: byte);
asm
  PUSH    EDI
  PUSH    EAX
  PUSH    EBX
  PUSH    ECX
  PUSH    EDX

  MOV     EDI, EAX
  XOR     EBX, EBX
  XOR     EAX, EAX
  MOV     EBX, W
  MOV     EAX, Y1
  MUL     EBX
  ADD     EAX, X1
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX

  MOV     EBX, X2
  SUB     EBX, X1
  INC     EBX
  TEST    EBX,EBX
  JS      @exit

  MOV     EDX, Y2
  SUB     EDX, Y1
  INC     EDX
  TEST    EDX,EDX
  JS      @exit
  mov     al, alpha

@1:
  PUSH    EDI
  MOV     ECX, EBX

@2:
  INC     EDI
  INC     EDI
  INC     EDI
  MOV     [EDI], AL
  INC     EDI
  LOOP    @2
 
  POP     EDI
  POP     ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  PUSH    ECX
  DEC     EDX
  CMP     EDX, 0
  JNE     @1

@exit:
  POP     EDX
  POP     ECX
  POP     EBX
  POP     EAX
  POP     EDI
end;

function _PixelAlphaBlend(F, B: TbsColor): TbsColor;
asm
  { Test Fa = 255  }
  CMP     EAX,$FF000000   // Fa = 255 ? => Result = EAX
  JNC     @2
  { Test Fa = 0 ? }
  TEST    EAX,$FF000000
  JZ      @1

  MOV     ECX,EAX
  SHR     ECX,24          // CL=Fa

  PUSH    EBX

  PUSH    EAX
  AND     EAX,$00FF00FF
  IMUL    EAX,ECX
  MOV     EBX, EDX
  AND     EBX,$00FF00FF
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EAX, EBX
  AND     EAX,$FF00FF00
  SHR     EAX, 8
  { EAX = BlendPixel.R and BlendPixel.B }
  POP     EBX
  AND     EBX,$0000FF00
  AND     EDX,$0000FF00
  SHR     EBX, 8
  SHR     EDX, 8
  IMUL    EDX, ECX
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EBX, EDX
  AND     EBX,$0000FF00
  ADD     EBX,$FF000000
  { EBX = BlendPixel.G }
  OR      EAX,EBX
  POP     EBX

  RET
@1:
  MOV     EAX,EDX
@2:
  RET
end;

procedure _LineAlphaBlend(Src, Dst: PbsColor; Count: Integer);
asm
  TEST    ECX,ECX
  JS      @4

  PUSH    EBX
  PUSH    ESI
  PUSH    EDI

  MOV     ESI,EAX
  MOV     EDI,EDX


@1:
  MOV     EAX,[ESI]
  MOV     EDX,[EDI]
  TEST    EAX,$FF000000
  JZ      @3

  PUSH    ECX

  MOV     ECX,EAX
  SHR     ECX,24

  CMP     ECX,$FF
  JZ      @2

  PUSH    EAX

  AND     EAX,$00FF00FF
  IMUL    EAX,ECX
  MOV     EBX, EDX
  AND     EBX,$00FF00FF
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EAX, EBX
  AND     EAX,$FF00FF00
  SHR     EAX, 8
  {BlendPixel.R b BlendPixel.B - EAX}
  POP     EBX
  AND     EBX,$0000FF00
  AND     EDX,$0000FF00
  SHR     EBX, 8
  SHR     EDX, 8
  IMUL    EDX, ECX
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EBX, EDX
  AND     EBX,$0000FF00
  ADD     EBX,$FF000000
  {BlendPixel.G - EBX}
  OR      EAX,EBX
  {BlendPixel - EAX}
@2:
  MOV     [EDI],EAX

  POP     ECX             // restore counter
@3:
  ADD     ESI,4
  ADD     EDI,4

  DEC     ECX
  JNZ     @1

  POP     EDI
  POP     ESI
  POP     EBX
@4:
  RET
end;

procedure _LineTransparent(Src, Dst: PbsColor; Count: Integer);
asm
  TEST    ECX,ECX
  JS      @4

  PUSH    ESI
  PUSH    EDI
  PUSH    EBX

  MOV     EBX, bsTransparent
  MOV     ESI,EAX
  MOV     EDI,EDX

@1:
  MOV     EAX,[ESI]
  MOV     EDX, EAX

  AND     EAX, NOT ALPHAMASK
  CMP     EAX, EBX
  JE      @3

  OR      EDX, AlphaMask
  MOV     [EDI], EDX

@3:
  ADD     ESI,4
  ADD     EDI,4

  DEC     ECX
  JNZ     @1

  POP     EBX
  POP     EDI
  POP     ESI

@4:
  RET
end;

{ MMX =========================================================================}

function Mmx_PixelAlphaBlend(F, B: TbsColor): TbsColor;
asm
  db $0F,$6E,$C0          // MOVD    MM0, EAX
  db $0F,$6E,$D2          // MOVD    MM2, EDX
  db $0F,$EF,$DB          // PXOR    MM3, MM3
  db $0F,$60,$C3          // PUNPCKLBW MM0, MM3
  db $0F,$60,$D3          // PUNPCKLBW MM2, MM3
  db $0F,$6F,$C8          // MOVQ      MM1,MM0
  db $0F,$69,$C9          // PUNPCKHWD MM1,MM1
  db $0F,$6A,$C9          // PUNPCKHDQ MM1,MM1
  db $0F,$F9,$C2          // PSUBW   MM0,MM2
  db $0F,$D5,$C1          // PMULLW  MM0,MM1
  db $0F,$71,$F2,$08      // PSLLW   MM2, 8
  db $0F,$FD,$D0          // PADDW   MM2, MM0
  db $0F,$71,$D2,$08      // PSRLW   MM2,8
  db $0F,$67,$D3          // C0PACKUSWB  MM2,MM3
  db $0F,$7E,$D0          // MOVD      EAX,MM2
end;

procedure Mmx_LineAlphaBlend(Src, Dst: PbsColor; Count: Integer);
asm
  TEST      ECX,ECX
  JS        @4

  PUSH      ESI
  PUSH      EDI

  MOV       ESI,EAX
  MOV       EDI,EDX
@1:
  MOV       EAX,[ESI]
  TEST      EAX,$FF000000
  JZ        @3
  CMP       EAX,$FF000000
  JNC       @2

  db $0F,$6E,$C0          // MOVD    MM0, EAX
  db $0F,$6E,$17          // MOVD    MM2, [EDI]
  db $0F,$EF,$DB          // PXOR    MM3, MM3
  db $0F,$60,$C3          // PUNPCKLBW MM0, MM3
  db $0F,$60,$D3          // PUNPCKLBW MM2, MM3
  db $0F,$6F,$C8          // MOVQ      MM1,MM0
  db $0F,$69,$C9          // PUNPCKHWD MM1,MM1
  db $0F,$6A,$C9          // PUNPCKHDQ MM1,MM1
  db $0F,$F9,$C2          // PSUBW   MM0,MM2
  db $0F,$D5,$C1          // PMULLW  MM0,MM1
  db $0F,$71,$F2,$08      // PSLLW   MM2, 8
  db $0F,$FD,$D0          // PADDW   MM2, MM0
  db $0F,$71,$D2,$08      // PSRLW   MM2,8
  db $0F,$67,$D3          // C0PACKUSWB  MM2,MM3
  db $0F,$7E,$D0          // MOVD      EAX,MM2

@2:
  MOV       [EDI],EAX
@3:
  ADD       ESI,4
  ADD       EDI,4

  DEC       ECX
  JNZ       @1

  POP       EDI
  POP       ESI
@4:
  RET
end;

{ Initialization ==============================================================}

procedure SetupLowLevel;
begin
  if HasMMX then
  begin
    { MMX }
    PixelAlphaBlendFunc := Mmx_PixelAlphaBlend;
    LineAlphaBlendFunc := Mmx_LineAlphaBlend;
    LineTransparentFunc := _LineTransparent;

    MoveLongwordFunc := _MoveLongword;
    FillLongwordFunc := _FillLongword;
    FillLongwordRectFunc := _FillLongwordRect;

    FillAlphaFunc := _FillAlpha;
    FillAlphaRectFunc := _FillAlphaRect;

    ClearAlphaFunc := _ClearAlpha;
  end
  else
  begin
    { Non-MMX }
    PixelAlphaBlendFunc := _PixelAlphaBlend;
    LineAlphaBlendFunc := _LineAlphaBlend;
    LineTransparentFunc := _LineTransparent;

    MoveLongwordFunc := _MoveLongword;
    FillLongwordFunc := _FillLongword;
    FillLongwordRectFunc := _FillLongwordRect;

    FillAlphaFunc := _FillAlpha;
    FillAlphaRectFunc := _FillAlphaRect;

    ClearAlphaFunc := _ClearAlpha;
  end;
end;



function _GetBitsFromDC(DC: HDC; var Width, Height, BitCount: integer): Pointer;
var
  Bitmap: HBITMAP;
  DIB: TDIBSection;
begin
  Result := nil;
  Width := 0;
  Height := 0;
  BitCount := 0;

  Bitmap := GetCurrentObject(DC, OBJ_BITMAP);
  if Bitmap <> 0 then
  begin
    if GetObject(Bitmap, SizeOf(DIB), @DIB) = SizeOf(DIB) then
    begin
      Result := DIB.dsBm.bmBits;
      Width := DIB.dsBmih.biWidth;
      Height := DIB.dsBmih.biHeight;
      BitCount := DIB.dsBmih.biBitCount;
    end;
  end;
end;


{ DC functions ================================================================}


procedure _StretchToDCOpaque(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcBmp: TbsBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
begin
  SetStretchBltMode(DstDC, COLORONCOLOR);
  StretchBlt(DstDC, DstX, DstY, DstW, DstH, SrcBmp.DC, SrcX, SrcY, SrcW, SrcH, SRCCOPY);
end;

procedure _StretchToDCAlphaBlend(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcBmp: TbsBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
var
  SrcRect, DstRect: TRect;
  ResBmp: TbsBitmap;
begin
  { Stretch }
  SrcRect := Rect(SrcX, SrcY, SrcX + SrcW, SrcY + SrcH);
  DstRect := Rect(DstX, DstY, DstX + DstW, DstY + DstH);
  { Stretch }
  ResBmp := TbsBitmap.Create;
  ResBmp.SetSize(DstW, DstH);
  { Copy from DstDC  }
  BitBlt(ResBmp.DC, 0, 0, DstW, DstH, DstDC, DstX, DstY, SRCCOPY);
  { Draw bitmap transparent to ResBmp }
  SrcBmp.Draw(ResBmp, Rect(0, 0, DstW, DstH), SrcRect);
  { Draw ResBmp }
  BitBlt(DstDC, DstRect.Left, DstRect.Top, DstW, DstH, ResBmp.DC, 0, 0, SRCCOPY);
  { Free resource }
  ResBmp.Free;
end;

procedure _StretchToDCTransparent(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcBmp: TbsBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
var
  SrcRect, DstRect: TRect;
  ResBmp: TbsBitmap;
begin
  { Stretch }
  SrcRect := Rect(SrcX, SrcY, SrcX + SrcW, SrcY + SrcH);
  DstRect := Rect(DstX, DstY, DstX + DstW, DstY + DstH);
  { Stretch }
  ResBmp := TbsBitmap.Create;
  ResBmp.SetSize(DstW, DstH);
  { Copy DstDC  }
  BitBlt(ResBmp.DC, 0, 0, DstW, DstH, DstDC, DstX, DstY, SRCCOPY);
  { Draw bitmap transparent to ResBmp }
  SrcBmp.Draw(ResBmp, Rect(0, 0, DstW, DstH), SrcRect);
  { Draw ResBmp }
  BitBlt(DstDC, DstRect.Left, DstRect.Top, DstW, DstH, ResBmp.DC, 0, 0, SRCCOPY);
  { Free resource }
  ResBmp.Free;
end;

procedure MsImg_StretchToDCTransparent(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcBmp: TbsBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
begin
  { Use Win2k, WinXP TransparentBlt }
  TransparentBltFunc(DstDC, DstX, DstY, DstW, DstH, SrcBmp.DC, SrcX, SrcY,
    SrcW, SrcH, bsTransparent);
end;


{ Dib Routines ================================================================}


procedure _BltToDibOpaque(Bits: Pointer; DstX, DstY, BitsW, BitsH: integer;
  Src: TbsBitmap; SrcRect: TRect); overload;
var
  SrcP, DstP: PbsColor;
  W, H, Y: Integer;
begin
  if Src = nil then Exit;
  { Internal routine }
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  { Source bitmap }
  SrcP := Src.PixelPtr[SrcRect.Left, SrcRect.Top];
  if SrcP = nil then Exit;
  { 32-bit -DIB }
  DstP := @PbsColorArray(Bits)[DstX + (BitsH - DstY - 1) * BitsW];
  for Y := 0 to H - 1 do
  begin
    MoveLongwordFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Dec(DstP, BitsW);
  end;
end;

procedure _BltToDibTransparent(Bits: Pointer; DstX, DstY, BitsW, BitsH: integer;
  Src: TbsBitmap; SrcRect: TRect); overload;
var
  SrcP, DstP: PbsColor;
  W, H, Y: Integer;
begin
  if Src = nil then Exit;
  { Internal routine }
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  { Source bitmap }
  SrcP := Src.PixelPtr[SrcRect.Left, SrcRect.Top];
  if SrcP = nil then Exit;
  { 32-bit -DIB }
  DstP := @PbsColorArray(Bits)[DstX + (BitsH - DstY - 1) * BitsW];
  for Y := 0 to H - 1 do
  begin
    LineTransparentFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Dec(DstP, BitsW);
  end;
end;

procedure _BltToDibAlphaBlend(Bits: Pointer; DstX, DstY, BitsW, BitsH: integer;
  Src: TbsBitmap; SrcRect: TRect); overload;
var
  SrcP, DstP: PbsColor;
  W, H, Y: Integer;
begin
  if Src = nil then Exit;
  { Internal routine }
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  { Source bitmap }
  SrcP := Src.PixelPtr[SrcRect.Left, SrcRect.Top];
  if SrcP = nil then Exit;
  { 32-bit -DIB }
  DstP := @PbsColorArray(Bits)[DstX + (BitsH - DstY - 1) * BitsW];
  for Y := 0 to H - 1 do
  begin
    LineAlphaBlendFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Dec(DstP, BitsW);
  end;
end;

procedure _StretchToDibOpaque(Bits: Pointer; DstRect, DstClip: TRect;
  BitsW, BitsH: integer; Src: TbsBitmap; SrcRect: TRect); overload;
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PbsColorArray;
  Scale: Single;
begin
  if IsRectEmpty(SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, Rect(0, 0, BitsW, BitsH));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      _BltToDibOpaque(Bits, DstClip.Left, DstClip.Top, BitsW, BitsH,
        Src, SrcRect);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Round(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      DstLine := @PbsColorArray(Bits)[DstClip.Left + (BitsH - DstClip.Top - 1) * BitsW];
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
          SrcY := Round(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale)
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do DstLine[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end
        else
          MoveLongwordFunc(@DstLine[-BitsW], @DstLine[0], DstClipW);
        Dec(DstLine, BitsW);
      end;
    end;
  finally
    EMMS;
  end;
end;

procedure _StretchToDibTransparent(Bits: Pointer; DstRect, DstClip: TRect;
  BitsW, BitsH: integer; Src: TbsBitmap; SrcRect: TRect); overload;
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PbsColorArray;
  Buffer: TArrayOfseColor;
  Scale: Single;
begin
  if IsRectEmpty(SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, Rect(0, 0, BitsW, BitsH));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      Assert(Bits<>nil);
      Assert(Src<>nil);
      _BltToDibTransparent(Bits, DstClip.Left, DstClip.Top, BitsW, BitsH,
        Src, SrcRect);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Round(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      SetLength(Buffer, DstClipW);
      DstLine := @PbsColorArray(Bits)[DstClip.Left + (BitsH - DstClip.Top - 1) * BitsW];
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
        begin
          EMMS;
          SrcY := Round(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
        end
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do Buffer[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end;

        LineTransparentFunc(@Buffer[0], @DstLine[0], DstClipW);

        Dec(DstLine, BitsW);
      end;
    end;
  finally
    EMMS;
  end;
end;

procedure _StretchToDibAlphaBlend(Bits: Pointer; DstRect, DstClip: TRect;
  BitsW, BitsH: integer; Src: TbsBitmap; SrcRect: TRect); overload;
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PbsColorArray;
  Buffer: TArrayOfseColor;
  Scale: Single;
begin
  if IsRectEmpty(SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, Rect(0, 0, BitsW, BitsH));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      _BltToDibAlphaBlend(Bits, DstClip.Left, DstClip.Top, BitsW, BitsH,
        Src, SrcRect);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Round(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      SetLength(Buffer, DstClipW);
      DstLine := @PbsColorArray(Bits)[DstClip.Left + (BitsH - DstClip.Top - 1) * BitsW];
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
        begin
          EMMS;
          SrcY := Round(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
        end
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do Buffer[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end;

        LineAlphaBlendFunc(@Buffer[0], @DstLine[0], DstClipW);

        Dec(DstLine, BitsW);
      end;
    end;
  finally
    EMMS;
  end;
end;


{ bsBitmap functions =========================================================}


procedure _BltOpaque(Dst: TbsBitmap; DstRect: TRect;
  Src: TbsBitmap; SrcX, SrcY: Integer); overload;
var
  SrcP, DstP: PbsColor;
  W, DstY: Integer;
begin
  { Internal routine }
  W := DstRect.Right - DstRect.Left;
  SrcP := Src.PixelPtr[SrcX, SrcY];
  Assert(SrcP<>nil);
  DstP := Dst.PixelPtr[DstRect.Left, DstRect.Top];
  Assert(DstP<>nil);
  for DstY := DstRect.Top to DstRect.Bottom - 1 do
  begin
    MoveLongwordFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Inc(DstP, Dst.Width);
  end;
end;

procedure _BltTransparent(Dst: TbsBitmap; DstRect: TRect;
  Src: TbsBitmap; SrcX, SrcY: Integer); overload;
var
  SrcP, DstP: PbsColor;
  W, DstY: Integer;
begin
  { Internal routine }
  W := DstRect.Right - DstRect.Left;
  SrcP := Src.PixelPtr[SrcX, SrcY];
  Assert(SrcP<>nil);
  DstP := Dst.PixelPtr[DstRect.Left, DstRect.Top];
  Assert(DstP<>nil);
  for DstY := DstRect.Top to DstRect.Bottom - 1 do
  begin
    LineTransparentFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Inc(DstP, Dst.Width);
  end;
end;

procedure _BltAlphaBlend(Dst: TbsBitmap; DstRect: TRect;
  Src: TbsBitmap; SrcX, SrcY: Integer); overload;
var
  SrcP, DstP: PbsColor;
  W, DstY: Integer;
begin
  { Internal routine }
  W := DstRect.Right - DstRect.Left;
  SrcP := Src.PixelPtr[SrcX, SrcY];
  Assert(SrcP<>nil);
  DstP := Dst.PixelPtr[DstRect.Left, DstRect.Top];
  Assert(DstP<>nil);
  for DstY := DstRect.Top to DstRect.Bottom - 1 do
  begin
    LineAlphaBlendFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Inc(DstP, Dst.Width);
  end;
end;

procedure _StretchOpaque(Dst: TbsBitmap; DstRect, DstClip: TRect;
  Src: TbsBitmap; SrcRect: TRect);
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PbsColorArray;
  Scale: Single;
begin
  if IsRectEmpty(SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, Rect(0, 0, Dst.Width, Dst.Height));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      BltOpaqueFunc(Dst, DstClip, Src, SrcRect.Left + DstClip.Left - DstRect.Left,
        SrcRect.Top + DstClip.Top - DstRect.Top);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Trunc(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      DstLine := PbsColorArray(Dst.PixelPtr[DstClip.Left, DstClip.Top]);
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
          SrcY := Trunc(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale)
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do DstLine[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end
        else
          MoveLongwordFunc(@DstLine[-Dst.Width], @DstLine[0], DstClipW);
        Inc(DstLine, Dst.Width);
      end;
    end;
  finally
    EMMS;
  end;
end;

procedure _StretchTransparent(Dst: TbsBitmap; DstRect, DstClip: TRect;
  Src: TbsBitmap; SrcRect: TRect);
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PbsColorArray;
  Buffer: TArrayOfseColor;
  Scale: Single;
begin
  if IsRectEmpty(SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, Rect(0, 0, Dst.Width, Dst.Height));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      BltTransparentFunc(Dst, DstClip, Src, SrcRect.Left + DstClip.Left - DstRect.Left,
        SrcRect.Top + DstClip.Top - DstRect.Top);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Trunc(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      SetLength(Buffer, DstClipW);
      DstLine := PbsColorArray(Dst.PixelPtr[DstClip.Left, DstClip.Top]);
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
        begin
          EMMS;
          SrcY := Trunc(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
        end
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do Buffer[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end;

        LineTransparentFunc(@Buffer[0], @DstLine[0], DstClipW);

        Inc(DstLine, Dst.Width);
      end;
    end;
  finally
    EMMS;
  end;
end;

procedure _StretchAlphaBlend(Dst: TbsBitmap; DstRect, DstClip: TRect;
  Src: TbsBitmap; SrcRect: TRect);
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PbsColorArray;
  Buffer: TArrayOfseColor;
  Scale: Single;
begin
  if IsRectEmpty(SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, Rect(0, 0, Dst.Width, Dst.Height));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      BltAlphaBlendFunc(Dst, DstClip, Src, SrcRect.Left + DstClip.Left - DstRect.Left,
        SrcRect.Top + DstClip.Top - DstRect.Top);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Trunc(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      SetLength(Buffer, DstClipW);
      DstLine := PbsColorArray(Dst.PixelPtr[DstClip.Left, DstClip.Top]);
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
        begin
          EMMS;
          SrcY := Trunc(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
        end
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do Buffer[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end;

        LineAlphaBlendFunc(@Buffer[0], @DstLine[0], DstClipW);

        Inc(DstLine, Dst.Width);
      end;
    end;
  finally
    EMMS;
  end;
end;

{ Setup functions =============================================================}

function GetCurrentColorDepth : Integer;
var
  topDC : HDC;
begin
  topDC:=GetDC(0);
  try
    Result:=GetDeviceCaps(topDC, BITSPIXEL)*GetDeviceCaps(topDC, PLANES);
  finally
    ReleaseDC(0, topDC);
  end;
end;

function IsTrueColor: boolean;
begin
  Result := GetCurrentColorDepth >= 24;
end;

procedure SetupFunctions;
begin
  StretchToDCOpaqueFunc := _StretchToDCOpaque;
  StretchToDCAlphaBlendFunc := _StretchToDCAlphaBlend;
  if IsMsImg and IsTrueColor then
    StretchToDCTransparentFunc := MsImg_StretchToDCTransparent
  else
    StretchToDCTransparentFunc := _StretchToDCTransparent;

  StretchToDibOpaqueFunc := _StretchToDibOpaque;
  StretchToDibAlphaBlendFunc := _StretchToDibAlphaBlend;
  StretchToDibTransparentFunc := _StretchToDibTransparent;

  StretchOpaqueFunc := _StretchOpaque;
  StretchAlphaBlendFunc := _StretchAlphaBlend;
  StretchTransparentFunc := _StretchTransparent;
  BltOpaqueFunc := _BltOpaque;
  BltAlphaBlendFunc := _BltAlphaBlend;
  BltTransparentFunc := _BltTransparent;

  GetBitsFromDCFunc := _GetBitsFromDC;


end;


// =============================================================================
procedure CheckRGB(var r, g, b: Integer);
begin
  if r > 255 then r := 255 else if r < 0 then r := 0;
  if g > 255 then g := 255 else if g < 0 then g := 0;
  if b > 255 then b := 255 else if b < 0 then b := 0;
end;

procedure TbsEffectBmp.SetPixel(x, y: Integer; Clr:Integer);
begin
  CopyMemory(
    Pointer(Integer(Bits) + (y * (Width mod 4)) + (((y * Width) + x) * 3)), @Clr, 3);
end;

function TbsEffectBmp.GetPixel(x,y:Integer):Integer;
begin
  CopyMemory(
    @Result,
    Pointer(Integer(Bits) + (y * (Width mod 4)) + (((y * Width) + x) * 3)), 3);
end;

procedure TbsEffectBmp.SetLine(y:Integer;Line:Pointer);
begin
  CopyMemory(
    Pointer(Integer(Bits) + (y*(Width mod 4)) + ((y * Width) * 3)), Line, Width * 3);
end;

function TbsEffectBmp.GetLine(y:Integer):Pointer;
begin
  Result := Pointer(Integer(Bits) + (y * (Width mod 4)) + ((y * Width) * 3));
end;

procedure TbsEffectBmp.GetScanLine(y:Integer;Line:Pointer);
begin
  CopyMemory(
    Line,
    Pointer(Integer(Bits) + (y * (Width mod 4)) + ((y * Width) * 3)), Width * 3);
end;

constructor TbsEffectBmp.Create(cx,cy:Integer);
begin
  Width := cx;
  Height := cy;
  Size := ((Width * 3) + (Width mod 4)) * Height;
  with BmpHeader do
  begin
    biSize := SizeOf(BmpHeader);
    biWidth := Width;
    biHeight := -Height;
    biPlanes := 1;
    biBitCount := 24;
    biCompression := BI_RGB;
  end;
  BmpInfo.bmiHeader := BmpHeader;
  Handle := CreateDIBSection(0, BmpInfo, DIB_RGB_COLORS, Bits, 0, 0);
end;

constructor TbsEffectBmp.CreateFromhWnd(hBmp:Integer);
var
  Bmp: Windows.TBITMAP;
  hDC: Integer;
begin
  hDC := CreateDC('DISPLAY', nil, nil, nil);
  SelectObject(hDC, hBmp);
  GetObject(hBmp, SizeOf(Bmp), @Bmp);
  Width := Bmp.bmWidth;
  Height := Bmp.bmHeight;
  Size := ((Width * 3) + (Width mod 4)) * Height;

  with BmpHeader do
  begin
    biSize := SizeOf(BmpHeader);
    biWidth := Width;
    biHeight := -Height;
    biPlanes := 1;
    biBitCount := 24;
    biCompression := BI_RGB;
  end;

  BmpInfo.bmiHeader := BmpHeader;
  Handle := CreateDIBSection(0, BmpInfo, DIB_RGB_COLORS, Bits, 0, 0);
  GetDIBits(hDC, hBmp, 0, Height, Bits, BmpInfo, DIB_RGB_COLORS);
  DeleteDC(hDC);
end;

constructor TbsEffectBmp.CreateCopy(hBmp:TbsEffectBmp);
begin
  BmpHeader := hBmp.BmpHeader;
  BmpInfo := hBmp.BmpInfo;
  Width := hBmp.Width;
  Height := hBmp.Height;
  Size := ((Width * 3) + (Width mod 4)) * Height;
  Handle := CreateDIBSection(0, BmpInfo, DIB_RGB_COLORS, Bits, 0 , 0);
  CopyMemory(Bits, hBmp.Bits, Size);
end;

procedure TbsEffectBmp.Stretch(hDC,x,y,cx,cy:Integer);
begin
  StretchDiBits(hDC,
                x, y, cx, cy,
                0, 0, Width, Height,
                Bits,
                BmpInfo,
                DIB_RGB_COLORS,
                SRCCOPY);
end;

procedure TbsEffectBmp.Draw(hDC,x,y:Integer);
begin
  SetDIBitsToDevice(hDC,
                    x, y, Width, Height,
                    0, 0, 0, Height,
                    Bits,
                    BmpInfo,
                    DIB_RGB_COLORS);
end;

procedure TbsEffectBmp.DrawRect(hDC,hx,hy,x,y,cx,cy:Integer);
begin
  StretchDiBits(hDC,
                hx, hy + cy - 1, cx,-cy + 1,
                x, Height - y, cx, -cy + 1,
                Bits,
                BmpInfo,
                DIB_RGB_COLORS,
                SRCCOPY);
end;

procedure TbsEffectBmp.Resize(Dst:TbsEffectBmp);
var
  xCount, yCount, x,y: Integer;
  xScale, yScale: Double;
begin
  xScale := (Dst.Width-1) / Width;
  yScale := (Dst.Height-1) / Height;

  for y := 0 to Height-1 do
  for x := 0 to Width-1 do
    begin
      for yCount := 0 to Round(yScale) do
      for xCount := 0 to Round(xScale) do
        Dst.Pixels[Round(xScale * x) + xCount, Round(yScale * y) + yCount] := Pixels[x,y];
    end;
end;

procedure TbsEffectBmp.Morph(BMP: TbsEffectBmp; Kf: Double);
var
  x, y, r, g, b: Integer;
  Line, L: PLine;
begin
  if (BMP.Width <> Width) or (BMP.Height <> Height) then Exit;
  if kf < 0 then kf := 0;
  if kf > 1 then kf := 1;
  GetMem(Line, Width * 3);
  for y := 0 to Height - 1 do
  begin
    GetScanLine(y,Line);
    L := BMP.ScanLines[y];
    for x := 0 to Width - 1 do
    begin
      r := Round(Line^[x].r * (1 - kf) + L^[x].r * kf);
      g := Round(Line^[x].g * (1 - kf) + L^[x].g * kf);
      b := Round(Line^[x].b * (1 - kf) + L^[x].b * kf);
      CheckRGB(r, g, b);
      Line^[x].r := r;
      Line^[x].g := g;
      Line^[x].b := b;
    end;
    ScanLines[y] := Line;
  end;

  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.MorphRect(BMP: TbsEffectBmp; Kf: Double;
                                 Rct: TRect;
                                 StartX, StartY: Integer);
var
  x,y, x1,y1, r, g, b : Integer;
  Line, L: PLine;
begin
  if kf < 0 then kf := 0;
  if kf > 1 then kf := 1;
  GetMem(Line,Width*3);
  y1 := StartY;
  for y := Rct.Top to Rct.Bottom - 1 do
  begin
    GetScanLine(y,Line);
    L := BMP.ScanLines[y1];
    x1 := StartX;
    for x := Rct.Left to Rct.Right - 1 do
    begin
      r := Round(Line^[x].r * (1 - kf) + L^[x1].r * kf);
      g := Round(Line^[x].g * (1 - kf) + L^[x1].g * kf);
      b := Round(Line^[x].b * (1 - kf) + L^[x1].b * kf);
      CheckRGB(r, g, b);
      Line^[x].r := r;
      Line^[x].g := g;
      Line^[x].b := b;
      Inc(x1);
    end;
    ScanLines[y] := Line;
    Inc(y1);
  end;
  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.CopyRect(BMP: TbsEffectBmp; Rct: TRect;
                                StartX, StartY:Integer);
var
  x,y,x1,y1: Integer;
  Line, L: PLine;
begin
  GetMem(Line,Width*3);
  y1 := StartY;
  if Rct.Right > Width - 1 then Rct.Right := Width - 1;
  if Rct.Bottom > Height - 1 then Rct.Bottom := Height - 1;
  for y := Rct.Top to Rct.Bottom do
  begin
    GetScanLine(y,Line);
    L := BMP.ScanLines[y1];
    x1 := StartX;
    for x := Rct.Left to Rct.Right do
    begin
      Line^[x] := L^[x1];
      Inc(x1);
    end;
    ScanLines[y] := Line;
    Inc(y1);
  end;
  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.MorphHGrad;
var
  x, y, r, g, b: Integer;
  Line, L: PLine;
  kf1: Double;
  step: Double;
  f : Double;
  p1, p2: Integer;
  Offset: Integer;
begin
  if (BMP.Width <> Width) or (BMP.Height <> Height) then Exit;
  GetMem(Line,Width * 3);

  Offset := Round(Width * kf);

  f := (Width - Offset) div 2;

  if f <> 0
  then
    Step := 1 / f
  else
    Step := 1;

  p1 := Width div 2 - Offset div 2;
  if p1 < 0 then p1 := 0;
  p2 := Width div 2 + Offset div 2;
  if p2 > Width - 1 then p2 := Width - 1;

  for y := 0 to Height - 1 do
  begin
    GetScanLine(y, Line);
    L := BMP.ScanLines[y];
    for x := p1 to p2 do
    begin
      Line^[x].r := L^[x].r;
      Line^[x].g := L^[x].g;
      Line^[x].b := L^[x].b;
     end;
     ScanLines[y] := Line;
   end;

  for y := 0 to Height - 1 do
  begin
    GetScanLine(y,Line);
    L := BMP.ScanLines[y];
    kf1 := 0;
    for x := p1 downto 0 do
    begin
      r := Round(Line^[x].r * kf1 + L^[x].r * (1 - kf1));
      g := Round(Line^[x].g * kf1 + L^[x].g * (1 - kf1));
      b := Round(Line^[x].b * kf1 + L^[x].b * (1 - kf1));
      CheckRGB(r, g, b);
      Line^[x].r := r;
      Line^[x].g := g;
      Line^[x].b := b;
      kf1 := kf1 + Step;
      if kf1 > 1 then kf1 := 1;
     end;
     ScanLines[y] := Line;
   end;

   for y := 0 to Height - 1 do
   begin
     GetScanLine(y,Line);
     L := BMP.ScanLines[y];
     kf1 := 0;
     for x := p2 to Width - 1 do
     begin
       r := Round(Line^[x].r * kf1 + L^[x].r * (1 - kf1));
       g := Round(Line^[x].g * kf1 + L^[x].g * (1 - kf1));
       b := Round(Line^[x].b * kf1 + L^[x].b * (1 - kf1));
       CheckRGB(r, g, b);
       Line^[x].r := r;
       Line^[x].g := g;
       Line^[x].b := b;
       kf1 := kf1 + Step;
       if kf1 > 1 then kf1 := 1;
     end;
     ScanLines[y] := Line;
   end;

  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.MorphVGrad;
var
  x, y, r, g, b: Integer;
  Line, L: PLine;
  kf1: Double;
  step: Double;
  f : Double;
  p1, p2: Integer;
  Offset: Integer;
begin
  if (BMP.Width <> Width) or (BMP.Height <> Height) then Exit;
  GetMem(Line, Width * 3);

  Offset := Round(Height * kf);

  f := (Height - 1 - Offset) div 2;

  if f <> 0
  then
    Step := 1 / f
  else
    Step := 0;

  p1 := Height div 2 - Offset div 2;
  if p1 < 0 then p1 := 0;
  p2 := Height div 2 + Offset div 2;
  if p2 > Height - 1 then p2 := Height - 1;

  for y := p1 to p2 do
  begin
    GetScanLine(y, Line);
    L := BMP.ScanLines[y];
    for x := 0 to Width - 1 do
    begin
      Line^[x].r := L^[x].r;
      Line^[x].g := L^[x].g;
      Line^[x].b := L^[x].b;
     end;
     ScanLines[y] := Line;
   end;

  kf1 := 0;
  for y := p1 downto 0 do
  begin
    GetScanLine(y,Line);
    L := BMP.ScanLines[y];
    for x := 0 to Width - 1 do
    begin
      r := Round(Line^[x].r * kf1 + L^[x].r * (1 - kf1));
      g := Round(Line^[x].g * kf1 + L^[x].g * (1 - kf1));
      b := Round(Line^[x].b * kf1 + L^[x].b * (1 - kf1));
      CheckRGB(r, g, b);
      Line^[x].r := r;
      Line^[x].g := g;
      Line^[x].b := b;
     end;
     ScanLines[y] := Line;
     kf1 := kf1 + Step;
     if kf1 > 1 then kf1 := 1;
   end;

   kf1 := 0;
   for y := p2 to Height - 1 do
   begin
     GetScanLine(y,Line);
     L := BMP.ScanLines[y];
     for x := 0 to Width - 1 do
     begin
       r := Round(Line^[x].r * kf1 + L^[x].r * (1 - kf1));
       g := Round(Line^[x].g * kf1 + L^[x].g * (1 - kf1));
       b := Round(Line^[x].b * kf1 + L^[x].b * (1 - kf1));
       CheckRGB(r, g, b);
       Line^[x].r := r;
       Line^[x].g := g;
       Line^[x].b := b;
     end;
     ScanLines[y] := Line;
     kf1 := kf1 + Step;
     if kf1 > 1 then kf1 := 1;
   end;

  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.MorphGrad;
begin
  if Width >= Height
  then MorphHGrad(BMP, kf)
  else MorphVGrad(BMP, kf);
end;

procedure TbsEffectBmp.MorphLeftGrad;
var
  x, y, r, g, b: Integer;
  Line, L: PLine;
  kf1: Double;
  step: Double;
  f : Integer;
begin
  if (BMP.Width <> Width) or (BMP.Height <> Height) then Exit;

  GetMem(Line, Width * 3);

  f := Round(Width * kf);
  if f < 1 then f := 1;
  if f > Width - 1 then f := Width - 1;

  if f > 0
  then
    Step := 1 / f
  else
    Step := 1;

  for y := 0 to Height - 1 do
  begin
    GetScanLine(y,Line);
    L := BMP.ScanLines[y];
    kf1 := 0;
    for x := 0 to f do
    begin
      r := Round(Line^[x].r * kf1 + L^[x].r * (1 - kf1));
      g := Round(Line^[x].g * kf1 + L^[x].g * (1 - kf1));
      b := Round(Line^[x].b * kf1 + L^[x].b * (1 - kf1));
      CheckRGB(r, g, b);
      Line^[x].r := r;
      Line^[x].g := g;
      Line^[x].b := b;
      kf1 := kf1 + Step;
      if kf1 > 1 then kf1 := 1;
     end;
     ScanLines[y] := Line;
   end;

  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.MorphRightGrad;
var
  x, y, r, g, b: Integer;
  Line, L: PLine;
  kf1: Double;
  step: Double;
  f : Integer;
begin
  if (BMP.Width <> Width) or (BMP.Height <> Height) then Exit;

  GetMem(Line, Width * 3);

  f := Width - Round(Width * kf);
  if f < 0 then f := 0;
  if f > Width - 1 then f := Width - 1;

  if Width - f > 0
  then
    Step := 1 / (Width - f)
  else
    Step := 1;

  for y := 0 to Height - 1 do
  begin
    GetScanLine(y,Line);
    L := BMP.ScanLines[y];
    kf1 := 0;
    for x := Width - 1 downto f do
    begin
      r := Round(Line^[x].r * kf1 + L^[x].r * (1 - kf1));
      g := Round(Line^[x].g * kf1 + L^[x].g * (1 - kf1));
      b := Round(Line^[x].b * kf1 + L^[x].b * (1 - kf1));
      CheckRGB(r, g, b);
      Line^[x].r := r;
      Line^[x].g := g;
      Line^[x].b := b;
      kf1 := kf1 + Step;
      if kf1 > 1 then kf1 := 1;
     end;
     ScanLines[y] := Line;
   end;
  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.MorphPush(BMP: TbsEffectBMP; Kf: Double);
var
  x, y, x1: Integer;
  Line, L: PLine;
  f : Integer;
begin
  if (BMP.Width <> Width) or (BMP.Height <> Height) then Exit;

  GetMem(Line, Width * 3);

  f := Round(Width * kf);
  if f < 0
  then f := 0
  else if f > Width - 1 then f := Width - 1;

  for y := 0 to Height - 1 do
  begin
    GetScanLine(y,Line);
    L := BMP.ScanLines[y];
    for x := Width - 1 downto f do
    begin
      x1 := x - f - 1;
      if x1 < 0 then x1 := 0;
      Line^[x].r := Line^[x1].r;
      Line^[x].g := Line^[x1].g;
      Line^[x].b := Line^[x1].b;
     end;
     ScanLines[y] := Line;
   end;           

  for y := 0 to Height - 1 do
  begin
    GetScanLine(y,Line);
    L := BMP.ScanLines[y];
    x1 := Width - f - 1;
    if x1 < 0 then x1 := 0;
    for x := 0 to f do
    begin
      Line^[x].r := L^[x1].r;
      Line^[x].g := L^[x1].g;
      Line^[x].b := L^[x1].b;
      inc(x1);
      if x1 > Width - 1 then x1 := Width - 1;
    end;
    ScanLines[y] := Line;
  end;

  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.MorphLeftSlide;
var
  x, y, x1: Integer;
  Line, L: PLine;
  f : Integer;
begin
  if (BMP.Width <> Width) or (BMP.Height <> Height) then Exit;

  GetMem(Line, Width * 3);

  f := Round(Width * kf);
  if f < 1 then f := 1;
  if f > Width - 1 then f := Width - 1;
  for y := 0 to Height - 1 do
  begin
    GetScanLine(y,Line);
    L := BMP.ScanLines[y];
    x1 := Width - 1 - f;
    if x1 < 0 then x1 := 0;
    for x := 0 to f - 1 do
    begin
      inc(x1);
      if x1 > Width -1 then x1 := Width - 1;
      Line^[x].r := L^[x1].r;
      Line^[x].g := L^[x1].g;
      Line^[x].b := L^[x1].b;
    end;
    ScanLines[y] := Line;
  end;

  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.MorphRightSlide;
var
  x, y, x1: Integer;
  Line, L: PLine;
  f : Integer;
begin
  if (BMP.Width <> Width) or (BMP.Height <> Height) then Exit;

  GetMem(Line, Width * 3);

  f := Round(Width * kf);
  if f < 1 then f := 1;
  if f > Width - 1 then f := Width - 1;

  for y := 0 to Height - 1 do
  begin
    GetScanLine(y,Line);
    L := BMP.ScanLines[y];
    x1 := Width - 1 - f;
    if x1 < 0 then x1 := 0;
    for x := 0 to f - 1 do
    begin
      inc(x1);
      if x1 > Width -1 then x1 := Width - 1;
      Line^[x1].r := L^[x].r;
      Line^[x1].g := L^[x].g;
      Line^[x1].b := L^[x].b;
    end;
    ScanLines[y] := Line;
  end;

  FreeMem(Line, Width * 3);
end;

destructor TbsEffectBmp.Destroy;
begin
  DeleteObject(Handle);
  inherited;
end;

procedure TbsEffectBmp.ChangeBrightness(Kf: Double);
var
  x, y, r, g, b: Integer;
  Line: PLine;
begin
  if Kf < 0 then Kf := 0 else if Kf > 1 then Kf := 1;
  GetMem(Line, Width * 3);
  for y := 0 to Height - 1 do
  begin
    GetScanLine(y, Line);
    for x := 0 to Width - 1 do
    begin
      r := Round(Line^[x].r * (1 - Kf) + 255 * Kf);
      g := Round(Line^[x].g * (1 - Kf) + 255 * Kf);
      b := Round(Line^[x].b * (1 - Kf) + 255 * Kf);
      CheckRGB(r, g, b);
      Line^[x].r := r;
      Line^[x].g := g;
      Line^[x].b := b;
    end;
    ScanLines[y] := Line;
  end;
  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.Invert;
var
  x, y, r, g, b: Integer;
  Line: PLine;
begin
  GetMem(Line, Width * 3);
  for y := 0 to Height - 1 do
  begin
    GetScanLine(y, Line);
    for x := 0 to Width - 1 do
    begin
      r := not Line^[x].r;
      g := not Line^[x].g;
      b := not Line^[x].b;
      CheckRGB(r, g, b);
      Line^[x].r := r;
      Line^[x].g := g;
      Line^[x].b := b;
    end;
    ScanLines[y] := Line;
  end;
  FreeMem(Line, Width * 3);
end;


procedure TbsEffectBmp.ChangeDarkness(Kf: Double);
var
  x, y, r, g, b: Integer;
  Line: PLine;
begin
  if Kf < 0 then Kf := 0 else if Kf > 1 then Kf := 1;
  GetMem(Line, Width * 3);
  for y := 0 to Height - 1 do
  begin
    GetScanLine(y, Line);
    for x := 0 to Width - 1 do
    begin
      r := Round(Line^[x].r * (1 - Kf));
      g := Round(Line^[x].g * (1 - Kf));
      b := Round(Line^[x].b * (1 - Kf));
      CheckRGB(r, g, b);
      Line^[x].r := r;
      Line^[x].g := g;
      Line^[x].b := b;
    end;
    ScanLines[y] := Line;
  end;
  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.GrayScale;
var
  x, y: Integer;
  Line: PLine;
  Gray: Byte;
begin
  GetMem(Line, Width * 3);
  for y := 0 to Height - 1 do
  begin
    GetScanLine(y, Line);
    for x := 0 to Width - 1 do
    begin
      Gray := Round(Line^[x].r * 0.3 + Line^[x].g * 0.59 + Line^[x].b * 0.11);
      if Gray > 255 then Gray := 255 else if Gray < 0 then Gray := 0;
      Line^[x].r := Gray;
      Line^[x].g := Gray;
      Line^[x].b := Gray;
    end;
    ScanLines[y] := Line;
  end;
  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.SplitBlur(Amount: Integer);
var
  cx, x, y: Integer;
  L, L1, L2: PLine;
  Buf: array[0..3] of TFColor;
  Tmp: TFColor;
begin
  if Amount = 0 then Exit;
  for y := 0 to Height-1 do
  begin
    L := ScanLines[y];
    if y - Amount < 0
    then L1:=ScanLines[y]
    else L1:=ScanLines[y - Amount];
    if y + Amount < Height
    then L2:=ScanLines[y + Amount]
    else L2:=ScanLines[Height - y];
    for x := 0 to Width - 1 do
    begin
      if x - Amount < 0 then cx := x else cx := x - Amount;
      Buf[0] := L1[cx];
      Buf[1] := L2[cx];
      if x + Amount < Width then cx := x + Amount else cx := Width - x;
      Buf[2] := L1^[cx];
      Buf[3] := L2^[cx];
      Tmp.r := (Buf[0].r + Buf[1].r + Buf[2].r + Buf[3].r) div 4;
      Tmp.g := (Buf[0].g + Buf[1].g + Buf[2].g + Buf[3].g) div 4;
      Tmp.b := (Buf[0].b + Buf[1].b + Buf[2].b + Buf[3].b) div 4;
      L^[x] := Tmp;
    end;
  end;
end;

procedure TbsEffectBmp.Mosaic(ASize: Integer);
var
  x, y, i, j : Integer;
  L1, L2: PLine;
  r, g, b : Byte;
begin
  y := 0;
  repeat
    L1 := Scanlines[y];
    x := 0;
    repeat
      j := 1;
      repeat
      L2 := Scanlines[y];
      x := 0;
      repeat
        r := L1[x].r;
        g := L1[x].g;
        b := L1[x].b;
        i:=1;
       repeat
       L2[x].r := r;
       L2[x].g := g;
       L2[x].b := b;
       inc(x);
       inc(i);
       until (x >= Width) or (i > ASize);
      until x >= Width;
      inc(j);
      inc(y);
      until ( y >= Height) or (j > ASize);
    until (y >= Height) or (x >= Width);
  until y >= Height;
end;


procedure TbsEffectBmp.AddMonoNoise(Amount:Integer);
var
  x,y,r,g,b,z: Integer;
  Line: PLine;
begin
  GetMem(Line, Width * 3);
  for y := 0 to Height - 1 do
  begin
    GetScanLine(y,Line);
    for x:=0 to Width-1 do
    begin
      z := Random(Amount) - Amount div 2;
      r := Line^[x].r + z;
      g := Line^[x].g + z;
      b := Line^[x].b + z;
      CheckRGB(r, g, b);
      Line^[x].r := r;
      Line^[x].g := g;
      Line^[x].b := b;
    end;
    ScanLines[y] := Line;
  end;
  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.AddColorNoise(Amount:Integer);
var
  x,y,r,g,b: Integer;
  Line: PLine;
begin
  GetMem(Line, Width * 3);
  for y := 0 to Height - 1 do
  begin
    GetScanLine(y,Line);
    for x:=0 to Width-1 do
    begin
      r := Line^[x].r + (Random(Amount) - (Amount div 2));
      g := Line^[x].g + (Random(Amount) - (Amount div 2));
      b := Line^[x].b + (Random(Amount) - (Amount div 2));
      CheckRGB(r, g, b);
      Line^[x].r := r;
      Line^[x].g := g;
      Line^[x].b := b;
    end;
    ScanLines[y] := Line;
  end;
  FreeMem(Line, Width * 3);
end;

procedure TbsEffectBmp.Rotate90_1(Dst: TbsEffectBmp);
var
  x, y: Integer;
begin
  for y := 0 to Height - 1 do
  for x := 0 to Width - 1 do
    Dst.Pixels[y, Width - 1 - x] := Pixels[x, y];
end;

procedure TbsEffectBmp.Rotate90_2(Dst: TbsEffectBmp);
var
  x, y: Integer;
begin
  for y := 0 to Height - 1 do
  for x := 0 to Width - 1 do
    Dst.Pixels[Height - 1 - y, x] := Pixels[x, y];
end;

procedure TbsEffectBmp.FlipVert;
var
  x, y: Integer;
begin
  for y := 0 to Height - 1 do
  for x := 0 to Width - 1 do
    Dst.Pixels[x, Height - 1 - y] := Pixels[x, y];
end;

procedure TbsEffectBmp.Wave;
var
  Tmp: TbsEffectBmp;
  i, j, XSrc, YSrc: Integer;
begin
  if (YDiv = 0)or (XDiv =0 ) then Exit;
  Tmp := TbsEffectBmp.CreateCopy(Self);
  for i := 0 to Width - 1 do
  for j := 0 to Height - 1 do
  begin
    XSrc := Round(i + RatioVal * Sin(j / YDiv));
    YSrc := Round(j + RatioVal * Sin(i / XDiv));
    if XSrc < 0 then XSrc := 0 else if XSrc >= Tmp.Width then XSrc := Tmp.Width - 1;
    if YSrc < 0 then YSrc := 0 else if YSrc >= Tmp.Height then YSrc := Tmp.Height - 1;
    Pixels[i,j] := Tmp.Pixels[XSrc,YSrc];
  end;
  Tmp.Free;
end;

procedure TbsEffectBmp.MaskAntialiasing(Msk: TbsEffectBmp; Amount: Integer);
var
  Lin, Lin1, Lin2, MskLine, MLin1, MLin2: PLine;
  cx, x, y: Integer;
  MBuf, Buf: array[0..3] of TFColor;
  r, g, b: Integer;
begin
  if Amount = 0 then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if (Width <> Msk.Width) or (Height > Msk.Height) then Exit;

  for y := 0 to Height-1 do
  begin
    Lin := ScanLines[y];

    if y - Amount < 0
    then Lin1 := ScanLines[y]
    else Lin1 := ScanLines[y - Amount];

    if y + Amount < Height
    then Lin2 := ScanLines[y + Amount]
    else Lin2 := ScanLines[Height - y];


    if y - Amount < 0
    then MLin1 := Msk.ScanLines[y]
    else MLin1 := Msk.ScanLines[y - Amount];

    if y + Amount < Msk.Height
    then MLin2 := Msk.ScanLines[y + Amount]
    else MLin2 := Msk.ScanLines[Height - y];


    MskLine := Msk.ScanLines[y];

    for x := 0 to Width - 1 do
    if not ((MskLine^[x].r = 255) and (MskLine^[x].g = 255)  and (MskLine^[x].b = 255))
    then
    begin
      if x - Amount < 0 then cx := x else cx := x - Amount;
      Buf[0] := Lin1^[cx];
      Buf[1] := Lin2^[cx];
      if x + Amount < Width then cx := x + Amount else cx := Width - x;
      Buf[2] := Lin1^[cx];
      Buf[3] := Lin2^[cx];
      //
      if x - Amount < 0 then cx := x else cx := x - Amount;
      MBuf[0] := MLin1^[cx];
      MBuf[1] := MLin2^[cx];
      if x + Amount < Width then cx := x + Amount else cx := Width - x;
      MBuf[2] := MLin1^[cx];
      MBuf[3] := MLin2^[cx];
      //
      if ((MBuf[0].r = 255) and (MBuf[0].g = 255) and (MBuf[0].b = 255)) or
         ((MBuf[1].r = 255) and (MBuf[1].g = 255) and (MBuf[1].b = 255)) or
         ((MBuf[2].r = 255) and (MBuf[2].g = 255) and (MBuf[2].b = 255)) or
         ((MBuf[3].r = 255) and (MBuf[3].g = 255) and (MBuf[3].b = 255))
      then
        begin
          r := (Buf[0].r + Buf[1].r + Buf[2].r + Buf[3].r) div 4;
          g := (Buf[0].g + Buf[1].g + Buf[2].g + Buf[3].g) div 4;
          b := (Buf[0].b + Buf[1].b + Buf[2].b + Buf[3].b) div 4;
          CheckRGB(r, g, b);
          Lin^[x].r := r;
          Lin^[x].g := g;
          Lin^[x].b := b;
        end;
    end;
  end;
end;

procedure TbsEffectBmp.MaskBlur(Msk: TbsEffectBmp; Amount: Integer);
var
  Lin, Lin1, Lin2, MskLine: PLine;
  cx, x, y: Integer;
  Buf: array[0..3] of TFColor;
  r, g, b: Integer;
begin
  if Amount = 0 then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if (Width <> Msk.Width) or (Height > Msk.Height) then Exit;

  for y := 0 to Height-1 do
  begin
    Lin := ScanLines[y];

    if y - Amount < 0
    then Lin1 := ScanLines[y]
    else Lin1 := ScanLines[y - Amount];

    if y + Amount < Height
    then Lin2 := ScanLines[y + Amount]
    else Lin2 := ScanLines[Height - y];

    MskLine := Msk.ScanLines[y];

    for x := 0 to Width - 1 do
    if not ((MskLine^[x].r = 255) and (MskLine^[x].g = 255)  and (MskLine^[x].b = 255))
    then
    begin
      if x - Amount < 0 then cx := x else cx := x - Amount;
      Buf[0] := Lin1^[cx];
      Buf[1] := Lin2^[cx];
      if x + Amount < Width then cx := x + Amount else cx := Width - x;
      Buf[2] := Lin1^[cx];
      Buf[3] := Lin2^[cx];
      r := (Buf[0].r + Buf[1].r + Buf[2].r + Buf[3].r) div 4;
      g := (Buf[0].g + Buf[1].g + Buf[2].g + Buf[3].g) div 4;
      b := (Buf[0].b + Buf[1].b + Buf[2].b + Buf[3].b) div 4;
      CheckRGB(r, g, b);
      Lin^[x].r := r;
      Lin^[x].g := g;
      Lin^[x].b := b;
    end;
  end;
end;

procedure TbsEffectBmp.MaskFillColor(Msk: TbsEffectBmp; C: TColor; kf: Double);
var
  Lin, MskLine: PLine;
  x, y: Integer;
  r, g, b: Integer;
  cr, cg, cb: Integer;
begin
  if (Width = 0) or (Height = 0) then Exit;
  if (Width <> Msk.Width) or (Height > Msk.Height) then Exit;
  cr := GetRValue(ColorToRGB(C));
  cg := GetGValue(ColorToRGB(C));
  cb := GetBValue(ColorToRGB(C));
  for y := 0 to Height - 1 do
  begin
    Lin := ScanLines[y];
    MskLine := Msk.ScanLines[y];
    for x := 0 to Width - 1 do
    if not ((MskLine^[x].r = 255) and (MskLine^[x].g = 255)  and (MskLine^[x].b = 255))
    then
      begin
        r := Round(Lin^[x].r * (1 - kf) + cr * kf);
        g := Round(Lin^[x].g * (1 - kf) + cg * kf);
        b := Round(Lin^[x].b * (1 - kf) + cb * kf);
        CheckRGB(r, g, b);
        Lin^[x].r := r;
        Lin^[x].g := g;
        Lin^[x].b := b;
      end;
  end;
end;


// Effects for text
type
  PIntArray = ^TIntArray;
  TIntArray = array [0..0] of integer;


procedure Blur(const Bitmap: TbsBitmap; const Radius: integer);
var
  pix: PbsColorArray;
  w, h, wm, hm, wh, vdiv: integer;
  rsum,gsum,bsum,x,y,i,yp,yi,yw: integer;
  P: cardinal;
  divsum: integer;
  stackpointer, stackstart: integer;
  sir: PbsColorRec;
  rbs, r1, routsum, goutsum, boutsum, rinsum, ginsum, binsum: integer;
  dv: PIntArray;
  vmin: PIntArray;
  r, g, b: PIntArray;
  stack: PbsColorArray;
begin
  if (radius<1) then Exit;

  pix := Bitmap.Scanline[0];

  w := Bitmap.width;
  h := Bitmap.height;
  wm := w - 1;
  hm := h - 1;
  wh := w * h;
  vdiv := radius + radius + 1;

  GetMem(r, wh * SizeOf(Integer));
  GetMem(g, wh * SizeOf(Integer));
  GetMem(b, wh * SizeOf(Integer));
  GetMem(vmin, max(w, h) * SizeOf(Integer));
  divsum := (vdiv + 1) shr 1;
  divsum := divsum * divsum;
  GetMem(dv, 256 * divsum * SizeOf(Integer));
  for i := 0 to 256 * divsum - 1 do
    dv[i] := (i div divsum);

  yw := 0;
  yi := 0;

  GetMem(stack, vdiv * SizeOf(TbsColor));

  r1 := radius + 1;

  for y := 0 to h - 1 do
  begin
    rinsum := 0;
    ginsum := 0;
    binsum := 0;
    routsum := 0;
    goutsum := 0;
    boutsum := 0;
    rsum := 0;
    gsum := 0;
    bsum :=0;
    for i := -radius to radius do
    begin
      p := pix[yi+min(wm,max(i,0))];
      sir := @stack[i + radius];
      sir.Color := p;
      rbs := r1-abs(i);
      rsum := rsum + (sir.r*rbs);
      gsum := gsum + (sir.g*rbs);
      bsum := bsum + (sir.b*rbs);
      if (i > 0) then
      begin
        rinsum := rinsum + sir.r;
        ginsum := ginsum + sir.g;
        binsum := binsum + sir.b;
      end else
      begin
        routsum := routsum + sir.r;
        goutsum := goutsum + sir.g;
        boutsum := boutsum + sir.b;
      end
    end;
    stackpointer := radius;

    for x := 0 to w - 1 do
    begin
      r[yi] := dv[rsum];
      g[yi] := dv[gsum];
      b[yi] := dv[bsum];

      rsum := rsum - routsum;
      gsum := gsum - goutsum;
      bsum := bsum - boutsum;

      stackstart := stackpointer-radius+vdiv;
      sir := @stack[stackstart mod vdiv];

      routsum := routsum - sir.r;
      goutsum := goutsum - sir.g;
      boutsum := boutsum - sir.b;

      if (y=0)then
      begin
        vmin[x] := min(x+radius+1,wm);
      end;                            
      p := pix[yw+vmin[x]];
      sir.color := p;

      rinsum := rinsum + sir.r;
      ginsum := ginsum + sir.g;
      binsum := binsum + sir.b;

      rsum := rsum + rinsum;
      gsum := gsum + ginsum;
      bsum := bsum + binsum;

      stackpointer :=(stackpointer+1) mod vdiv;
      sir := @stack[(stackpointer) mod vdiv];

      routsum := routsum + sir.r;
      goutsum := goutsum + sir.g;
      boutsum := boutsum + sir.b;

      rinsum := rinsum - sir.r;
      ginsum := ginsum - sir.g;
      binsum := binsum - sir.b;

      yi := yi + 1;
    end;
    yw := yw + w;
  end;

  for x := 0 to w - 1 do
  begin
    rinsum := 0;
    ginsum := 0;
    binsum := 0;
    routsum := 0;
    goutsum := 0;
    boutsum := 0;
    rsum := 0;
    gsum := 0;
    bsum :=0;
    yp := -radius * w;
    for i := -radius to radius do
    begin
      yi := max(0,yp) + x;

      sir := @stack[i+radius];

      sir.r := r[yi];
      sir.g := g[yi];
      sir.b := b[yi];

      rbs := r1 - abs(i);

      rsum := rsum + (r[yi]*rbs);
      gsum := gsum + (g[yi]*rbs);
      bsum := bsum + (b[yi]*rbs);

      if (i > 0)then
      begin
        rinsum := rinsum + sir.r;
        ginsum := ginsum + sir.g;
        binsum := binsum + sir.b;
      end else
      begin
        routsum := routsum + sir.r;
        goutsum := goutsum + sir.g;
        boutsum := boutsum + sir.b;
      end;

      if (i < hm) then
      begin
        yp := yp + w;
      end
    end;
    yi := x;
    stackpointer := radius;
    for y := 0 to h - 1 do
    begin
      pix[yi] := $FF000000 or (dv[rsum] shl 16) or (dv[gsum] shl 8) or dv[bsum];

      rsum := rsum - routsum;
      gsum := gsum - goutsum;
      bsum := bsum - boutsum;

      stackstart := stackpointer-radius+vdiv;
      sir := @stack[stackstart mod vdiv];

      routsum := routsum - sir.r;
      goutsum := goutsum - sir.g;
      boutsum := boutsum - sir.b;

      if (x = 0) then
      begin
        vmin[y] := min(y+r1,hm)*w;
      end;
      p := x + vmin[y];

      sir.r := r[p];
      sir.g := g[p];
      sir.b := b[p];

      rinsum := rinsum + sir.r;
      ginsum := ginsum + sir.g;
      binsum := binsum + sir.b;

      rsum := rsum + rinsum;
      gsum := gsum + ginsum;
      bsum := bsum + binsum;

      stackpointer := (stackpointer + 1) mod vdiv;
      sir := @stack[stackpointer];

      routsum := routsum + sir.r;
      goutsum := goutsum + sir.g;
      boutsum := boutsum + sir.b;

      rinsum := rinsum - sir.r;
      ginsum := ginsum - sir.g;
      binsum := binsum - sir.b;

      yi := yi + w;
    end;
  end;
  FreeMem(stack, vdiv * SizeOf(TbsColor));
  FreeMem(dv, 256 * divsum * SizeOf(Integer));
  FreeMem(vmin, max(w, h) * SizeOf(Integer));
  FreeMem(r, wh * SizeOf(Integer));
  FreeMem(g, wh * SizeOf(Integer));
  FreeMem(b, wh * SizeOf(Integer));
end;

procedure DrawBlurMarker(const Canvas: TCanvas;
    ARect: TRect; MarkerColor: cardinal = $202020);
var
  B: TbsBitmap;
  BlurRadius1: Integer;
  R: TRect;
  i, j: Integer;
begin
  BlurRadius1 := 10;
  B := TbsBitmap.Create;  
  R := Rect(0, 0, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
  B.SetSize(R.Right + BlurRadius1 * 2, R.Bottom + BlurRadius1 * 2);
  with B.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := $FF;
    FillRect(Rect(BlurRadius1, B.Height div 2 - 1,
             B.Width - BlurRadius1, B.Height div 2 + 1));
  end;
  //
  Blur(B, BlurRadius1);
  for i := 0 to B.Width - 1 do
    for j := 0 to B.Height - 1 do
    begin
      PbsColorRec(B.PixelPtr[i, j]).Color := FromRGB(MarkerColor) and
        not $FF000000 or (PbsColorRec(B.PixelPtr[i, j]).R shl 24);
    end;
  B.AlphaBlend := true;
  B.Draw(Canvas, ARect.Left - BlurRadius1, ARect.Top - BlurRadius1);
  B.Draw(Canvas, ARect.Left - BlurRadius1, ARect.Top - BlurRadius1);
  B.Free;
end;

procedure CreateAlphaByMask(Bmp, MaskBmp: TbsBitmap);
var
  i, j: Integer;
  C, C1: PbsColor;
  R1, G1, B1, A1: Byte;
begin
  for i := 0 to Bmp.Width - 1 do
  for j := 0 to Bmp.Height - 1 do
    begin
      C := Bmp.PixelPtr[i, j];
      C1 := MaskBmp.PixelPtr[i, j];
      R1 := TbsColorRec(C1^).R;
      G1 := TbsColorRec(C1^).G;
      B1 := TbsColorRec(C1^).B;
      A1 := Trunc((R1 + G1 + B1) / 3);
      TbsColorRec(C^).A := A1;
    end;
end;

procedure CreateAlphaByMask2(Bmp, MaskBmp: TbsBitmap);
var
  i, j: Integer;
  C, C1: PbsColor;
  R1, G1, B1, A1: Byte;
begin
  for i := 0 to Bmp.Width - 1 do
  for j := 0 to Bmp.Height - 1 do
    begin
      C := Bmp.PixelPtr[i, j];
      C1 := MaskBmp.PixelPtr[i, j];
      R1 := TbsColorRec(C1^).R;
      G1 := TbsColorRec(C1^).G;
      B1 := TbsColorRec(C1^).B;
      A1 := Trunc((R1 + G1 + B1) / 3);
      TbsColorRec(C^).A := A1;
    end;
  Bmp.CheckRGBA2;  
end;


{for Alpha bitmap}

function ReadString(S: TStream): string;
var
  L: Integer;
begin
  L := 0;
  S.Read(L, SizeOf(L));
  SetLength(Result, L);
  S.Read(Pointer(Result)^, L);
end;

procedure WriteString(S: TStream; Value: string);
var
  L: Integer;
begin
  L := Length(Value);
  S.Write(L, SizeOf(L));
  S.Write(Pointer(Value)^, L);
end;

function GetToken(var S: string): string;
{ Return first token and remove it from S }
var
  i: byte;
  CopyS: string;
begin
  Result := '';
  CopyS := S;
  for i := 1 to Length(CopyS) do
  begin
    Delete(S, 1, 1);
    if CopyS[i] in [',', ' ', '(', ')', ';', ':', '='] then Break;
    Result := Result + CopyS[i];
  end;
  Result := Trim(Result);
  S := Trim(S);
end;

function GetToken(var S: string; Separators: string): string;
var
  i: byte;
  CopyS: string;
begin
  Result := '';
  CopyS := S;
  for i := 1 to Length(CopyS) do
  begin
    Delete(S, 1, 1);
    if Pos(CopyS[i], Separators) > 0 then Break;
    Result := Result + CopyS[i];
  end;
  Result := Trim(Result);
  S := Trim(S);
end;

function GetToken(var S: string; Separators: TTokenSeparators): string;
var
  i: byte;
  CopyS: string;
begin
  Result := '';
  CopyS := S;
  for i := 1 to Length(CopyS) do
  begin
    Delete(S, 1, 1);
    if CopyS[i] in Separators then Break;
    Result := Result + CopyS[i];
  end;
  Result := Trim(Result);
  S := Trim(S);
end;

function RectToString(R: TRect): string;
{ Convert TRect to string }
begin
  Result := '(' + IntToStr(R.Left) + ',' + IntToStr(R.Top) + ',' + IntToStr(R.Right) + ',' +
    IntToStr(R.Bottom) + ')';
end;

function StringToRect(S: string): TRect;
{ Convert string to TRect }
begin
  try
    Result.Left := StrToInt(GetToken(S));
    Result.Top := StrToInt(GetToken(S));
    Result.Right := StrToInt(GetToken(S));
    Result.Bottom := StrToInt(GetToken(S));
  except
    Result := Rect(0, 0, 0, 0);
  end;
end;

var
  MMX_ACTIVE: Boolean;

function CPUID_Available: Boolean;
asm
        MOV       EDX,False
        PUSHFD
        POP       EAX
        MOV       ECX,EAX
        XOR       EAX,$00200000
        PUSH      EAX
        POPFD
        PUSHFD
        POP       EAX
        XOR       ECX,EAX
        JZ        @1
        MOV       EDX,True
@1:     PUSH      EAX
        POPFD
        MOV       EAX,EDX
end;

function CPU_Signature: Integer;
asm
        PUSH    EBX
        MOV     EAX,1
        DW      $A20F   // CPUID
        POP     EBX
end;

function CPU_Features: Integer;
asm
        PUSH    EBX
        MOV     EAX,1
        DW      $A20F   // CPUID
        POP     EBX
        MOV     EAX,EDX
end;

function HasMMX: Boolean;
begin
  Result := False;
  if not CPUID_Available then Exit;              // no CPUID available
  if CPU_Signature shr 8 and $0F < 5 then Exit;  // not a Pentium class
  if CPU_Features and $800000 = 0 then Exit;     // no MMX
  Result := True;
end;
 
procedure EMMS;
begin
  if MMX_ACTIVE then
  asm
    db $0F,$77               /// EMMS
  end;
end;

const
  MsImg32 = 'msimg32.dll';

var
  MsImg32Lib: THandle = 0;
  MsImg32Available: boolean = false;

function IsMsImg: boolean;
begin
  Result := MsImg32Available;
end;

procedure GetWindowsVersion(var Major, Minor: Integer);
var
  Ver : Longint;
begin
  Ver := GetVersion;
  Major := LoByte(LoWord(Ver));
  Minor := HiByte(LoWord(Ver));
end;


function CheckW2kWXP: Boolean;
var
  Major, Minor : Integer;
begin
  GetWindowsVersion(major, minor);
  Result := (major > 5) or ((major = 5) and ((minor = 0) or (minor = 1) or (minor = 2)));
end;

procedure SetupMsImg;
begin
  if CheckW2KWXP then
  begin
    MsImg32Lib := LoadLibrary(MsImg32);
    if MsImg32Lib <> 0 then
    begin
      TransparentBltFunc := GetProcAddress(MsImg32Lib, 'TransparentBlt');
      AlphaBlendFunc := GetProcAddress(MsImg32Lib, 'AlphaBlend');
      MsImg32Available := true;
    end;
  end;
end;

{}


initialization

  MMX_ACTIVE := HasMMX;

  SetupMsImg;

  SetupLowLevel;
  SetupFunctions;

finalization

  if MsImg32Lib <> 0 then FreeLibrary(MsImg32Lib);
  
  FreeBitmapList;
end.
