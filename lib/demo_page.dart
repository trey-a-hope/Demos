import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  // Color for the picker shown in Card on the screen.
  late Color screenPickerColor;
  // Color for the picker in a dialog using onChanged.
  late Color dialogPickerColor;

  // Define custom colors. The 'guide' color values are from
  // https://material.io/design/color/the-color-system.html#color-theme-creation
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  /// Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };

  @override
  void initState() {
    screenPickerColor = Colors.blue;
    dialogPickerColor = Colors.red;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flex Color Picker 2.5.0'),
      ),
      body: Column(
        children: [
          // Show the color picker in sized box in a raised card.
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Card(
                elevation: 2,
                child: ColorPicker(
                  // Use the screenPickerColor as start color.
                  color: screenPickerColor,

                  // Update the screenPickerColor using the callback.
                  onColorChanged: (Color color) =>
                      setState(() => screenPickerColor = color),
                  width: 44,
                  height: 44,
                  borderRadius: 22,
                  heading: Text(
                    'Select color',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  subheading: Text(
                    'Select color shade',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
            ),
          ),

          ListTile(
            title: const Text('Select color above to change this color'),
            subtitle:
                Text('${ColorTools.materialNameAndCode(screenPickerColor)} '
                    'aka ${ColorTools.nameThatColor(screenPickerColor)}'),
            trailing: ColorIndicator(
              width: 44,
              height: 44,
              borderRadius: 22,
              color: screenPickerColor,
            ),
          ),
          Divider(),
          ListTile(
            title: const Text('Click this color to change it in a dialog'),
            subtitle: Text(
              '${ColorTools.materialNameAndCode(dialogPickerColor, colorSwatchNameMap: colorsNameMap)} ' +
                  'aka ${ColorTools.nameThatColor(dialogPickerColor)}',
            ),
            trailing: ColorIndicator(
              //TODO: Write out all methods.
              width: 44,
              height: 44,
              borderRadius: 4,
              color: dialogPickerColor,
              onSelectFocus: false,
              onSelect: () async {
                // Store current color before we open the dialog.
                final Color colorBeforeDialog = dialogPickerColor;
                // Wait for the picker to close, if dialog was dismissed,
                // then restore the color we had before it was opened.
                if (!(await colorPickerDialog())) {
                  setState(() {
                    dialogPickerColor = colorBeforeDialog;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      /// The active color selection when the color picker is created.
      color: dialogPickerColor,

      /// Required [ValueChanged] callback, called when user selects
      /// a new color with new color value.
      ///
      /// Called every time the color value changes when operating thumbs on the
      /// color wheel or color or transparency sliders
      ///
      /// Changing which picker type is viewed does not trigger this callback, it
      /// is not triggered until a color in the viewed picker is selected.
      onColorChanged: (Color color) =>
          setState(() => dialogPickerColor = color),

      /// Optional [ValueChanged] callback. Called when user starts color selection
      /// with current color value.
      ///
      /// When clicking a new color in color items, the color value before the
      /// selected new value was clicked is returned. It is also called
      /// with the current start color when user starts the interaction on the
      /// color wheel or on a color or transparency slider.
      onColorChangeStart: (Color color) => null,

      /// Optional [ValueChanged] callback. Called when user ends color selection
      /// with the new color value.
      ///
      /// When clicking a new color on color items, the clicked color is returned.
      /// It is also called with the resulting color value when user ends the
      /// interaction on the color wheel or on a color or transparency slider.
      onColorChangeEnd: (Color color) => null,

      /// A [ColorPickerType] to bool map. Defines which pickers are enabled in the
      /// color picker's sliding selector and thus available as color pickers.
      ///
      /// Available options are based on the [ColorPickerType] enum that
      /// includes values `both`, `primary`, `accent`, `bw`, `custom` and `wheel`.
      ///
      /// By default, a map that sets primary and accent pickers to true, and
      /// other pickers to false, is used.
      ///
      /// To modify key-value enable/disable pairs, you only have to provide values
      /// for the pairs you want to change from their default value. Any missing
      /// key-value pair in the provided map will keep their default value.
      pickersEnabled: <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },

      /// Set to true to allow selection of color swatch shades.
      ///
      /// If false, only the main color from a swatch is shown and can be selected.
      /// This is index [500] for Material primary colors and index [200] for accent
      /// colors. On the Wheel, only the selected color is shown there is no
      /// color related color swatch of the selected color shown.
      ///
      /// Defaults to true.
      enableShadesSelection: true,

      /// There is an extra index [850] used only by grey Material color in Flutter.
      /// If you want to include it in the grey color shades selection, then set
      /// this property to true.
      ///
      /// Defaults to false.
      includeIndex850: true,

      /// Set to true to allow selection of color tone from a tonal palette.
      ///
      /// When set to true, the ColorPicker will use Material 3 color utilities
      /// to compute a tonal palette for the selected color, allowing you to
      /// select a color tone from the Tonal Palette for the selected color.
      ///
      /// For more info on Material 3 Color system, see:
      /// https://m3.material.io/styles/color/the-color-system/key-colors-tones
      ///
      /// The picker item size for tonal palette color indicator items is
      /// 10/13 the size of defined width and height. This is done in order to
      /// as far as possible try to match the width of the Primary Material Swatch
      /// items total width, it has 10 colors, the M3 tonal palette has 13 colors.
      /// The idea is try to match their width when they are both shown.
      ///
      /// Defaults to false.
      enableTonalPalette: true,

      /// Cross axis alignment used to layout the main content of the
      /// color picker in its column layout.
      ///
      /// Defaults to CrossAxisAlignment.center.
      crossAxisAlignment: CrossAxisAlignment.center,

      /// Padding around the entire color picker content.
      ///
      /// Defaults to const EdgeInsets.all(16).
      padding: EdgeInsets.all(16),

      /// Vertical spacing between items in the color picker column.
      ///
      /// Defaults to 8 dp. Must be from 0 to 300 dp.
      columnSpacing: 8.0,

      /// Enable the opacity control for the color value.
      ///
      /// Set to true to allow users to control the opacity value of the
      /// selected color. The displayed Opacity value on the slider goes from 0%,
      /// which is totally transparent, to 100%, which if fully opaque.
      ///
      /// When enabled, the opacity value is not returned as a separate value,
      /// it is returned in the alpha channel of the returned ARGB color value, in
      /// the onColor callbacks.
      ///
      /// Defaults to false.
      enableOpacity: true,

      /// The height of the opacity slider track.
      ///
      /// Defaults to 36 dp. Must be between 8 - 50.
      opacityTrackHeight: 36,

      /// The width of the opacity slider track.
      ///
      /// If null, the slider fills to expand available width of the picker.
      /// If not null, it must be >= 150 dp.
      opacityTrackWidth: null,

      /// The radius of the thumb on the opacity slider.
      ///
      /// Defaults to 16 dp. Must be between 12 - 30.
      opacityThumbRadius: 16,

      /// Used to configure action buttons for the color picker dialog.
      ///
      /// Defaults to [ColorPickerActionButtons] ().
      actionButtons: const ColorPickerActionButtons(
        dialogCancelButtonLabel: 'Cancel',
        dialogCancelButtonType: ColorPickerActionButtonType.outlined,
        dialogOkButtonLabel: 'OK',
        dialogOkButtonType: ColorPickerActionButtonType.elevated,
      ),

      /// Used to configure the copy paste behavior of the color picker.
      ///
      /// Defaults to [ColorPickerCopyPasteBehavior] ().
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
        copyIcon: Icons.face,
      ),

      /// Icon data for the icon used to indicate the selected color.
      ///
      /// The size of the [selectedColorIcon] is 60% of the smaller of color
      /// indicator [width] and [height]. The color of indicator icon is
      /// black or white, based on what contrast best with the selected color.
      ///
      /// Defaults to a check mark [Icons.check].
      selectedColorIcon: Icons.check,

      /// Width of the color indicator items.
      ///
      /// Defaults to 40 dp. Must be from 15 to 150 dp.
      width: 40,

      /// Height of the color indicator items.
      ///
      /// Defaults to 40 dp. Must be from 15 to 150 dp.
      height: 40,

      /// The horizontal spacing between the color picker indicator items.
      ///
      /// Defaults to 4 dp. Must be from 0 to 50 dp.
      spacing: 4,

      /// The space between the color picker color item rows, when they need to
      /// be wrapped to multiple rows.
      ///
      /// Defaults to 4 dp. Must be from 0 to 50 dp.
      runSpacing: 4,

      /// The Material elevation of the color indicator items.
      ///
      /// Defaults to 0 dp. Must be >= 0.
      elevation: 4,

      /// Set to true, to show a 1 dp border around the color indicator items.
      ///
      /// This property is useful if the white/near white and black/near black
      /// shades color picker is enabled.
      ///
      /// Defaults to false.
      hasBorder: true,

      /// Border radius of the color indicator items.
      ///
      /// If null, it defaults to [width]/4. Must be from 0 to 50 dp, if not null.
      borderRadius: null,

      /// The color of the 1 dp optional border used on [ColorIndicator] and on
      /// [ColorWheelPicker], when each have their border toggle set to true.
      ///
      /// If no color is given, the border color defaults to
      /// Theme.of(context).dividerColor.
      borderColor: null,

      /// Diameter of the HSV based color wheel picker.
      ///
      /// Defaults to 190 dp. Must be from 100 to maximum 500 dp.
      wheelDiameter: 190,

      /// The stroke width of the color wheel circle.
      ///
      /// Defaults to 16 dp. Must be from 4 to maximum 50 dp.
      wheelWidth: 16,

      /// Padding between shade square inside the hue wheel and inner
      /// side of the wheel.
      ///
      /// Keep it reasonable in relation to wheelDiameter and wheelWidth, values
      /// from 0 to 20 are recommended.
      ///
      /// Defaults to 0 dp.
      wheelSquarePadding: 20,

      /// Border radius of the shade square inside the hue wheel.
      ///
      /// Keep it reasonable, the thumb center always goes out to the square box
      /// corner, regardless of this border radius. It is only for visual design,
      /// the edge color shades are in the sharp corner, even if not shown.
      ///
      /// Recommended values 0 to 16.
      ///
      /// Defaults to 4 dp.
      wheelSquareBorderRadius: 4,

      /// Set to true to show a 1 dp border around the color wheel.
      ///
      /// Defaults to false.
      wheelHasBorder: true,

      /// Title widget for the color picker.
      ///
      /// Typically a Text widget, e.g. `Text('ColorPicker')`. If not provided or
      /// null, there is no title on the toolbar of the color picker.
      ///
      /// This widget can be used instead of [heading] or with it, depends on design
      /// need.
      ///
      /// The title widget is like an app bar title in the sense that at
      /// the end of it, 1 to 4 actions buttons may also be present for copy, paste,
      /// select-close and cancel-close. The select-close and cancel-close actions
      /// should only be enabled when the picker is used in a dialog. The copy and
      /// paste actions can be enabled also when the picker is not in a dialog.
      title: null,

      /// Heading widget for the color picker.
      ///
      /// Typically a Text widget, e.g. `Text('Select color')`.
      /// If not provided or null, there is no heading for the color picker.
      heading: Text('Select color'),

      /// Subheading widget for the color shades selection.
      ///
      /// Typically a Text widget, e.g. `Text('Select color shade')`.
      /// If not provided or null, there is no subheading for the color shades.
      subheading: Text('Select color shade'),

      /// Subheading widget for the color tone selection.
      ///
      /// Typically a Text widget, e.g. `Text('Select Material 3 color tone')`.
      /// If not provided or null, there is no subheading for the color shades.
      tonalSubheading: Text('Select Material 3 color tone'),

      // /// Subheading widget for the HSV color wheel picker.
      // ///
      // /// Typically a Text widget, e.g.
      // /// `Text('Selected color and its material like shades')`.
      // ///
      // /// The color wheel uses a separate subheading widget so that it may have
      // /// another explanation, since its use case differs from the other subheading
      // /// cases. If not provided, there is no subheading for the color wheel picker.
      // final Widget? wheelSubheading;

      // /// Subheading widget for the recently used colors.
      // ///
      // /// Typically a Text widget, e.g. `Text('Recent colors')`.
      // /// If not provided or null, there is no subheading for the recent color.
      // /// The recently used colors subheading is not shown even if provided, when
      // /// [showRecentColors] is false.
      // final Widget? recentColorsSubheading;

      // /// Subheading widget for the opacity slider.
      // ///
      // /// Typically a Text widget, e.g. `Text('Opacity')`.
      // /// If not provided or null, there is no subheading for the opacity slider.
      // /// The opacity subheading is not shown even if provided, when
      // /// [enableOpacity] is false.
      // final Widget? opacitySubheading;

      // /// Set to true to show the Material name and index of the selected [color].
      // ///
      // /// Defaults to false.
      // final bool showMaterialName;

      // /// Text style for the displayed material color name in the picker.
      // ///
      // /// Defaults to `Theme.of(context).textTheme.bodyText2`, if not defined.
      // final TextStyle? materialNameTextStyle;

      // /// Set to true to show an English color name of the selected [color].
      // ///
      // /// Uses the [ColorTools.nameThatColor] function to give an English name to
      // /// any selected color. The function has a list of 1566 color codes and
      // /// their names, it finds the color that closest matches the given color in
      // /// the list and returns its color name.
      // ///
      // /// Defaults to false.
      // final bool showColorName;

      // /// Text style for the displayed color name in the picker.
      // ///
      // /// Defaults to `Theme.of(context).textTheme.bodyText2`, if not defined.
      // final TextStyle? colorNameTextStyle;

      // /// Set to true to show the RGB Hex color code of the selected [color].
      // ///
      // /// The color code can be copied with copy icon button or other enabled copy
      // /// actions in the color picker. On the wheel picker the color code can be
      // /// edited to enter and select a color of a known RGB hex value. If the
      // /// property [colorCodeReadOnly] has been set to false the color code field
      // /// can never be edited directly, it is then only used to display the code
      // /// of currently selected color.
      // ///
      // /// Defaults to false.
      // final bool showColorCode;

      // /// When true, the color code entry field uses the currently selected
      // /// color as its background color.
      // ///
      // /// This makes the color code entry field a large current color indicator
      // /// area, that changes color as the color value is changed.
      // /// The text color of the field, will automatically adjust for best contrast,
      // /// as will the opacity indicator text. Enabling this feature will override
      // /// any color specified in [colorCodeTextStyle] and [colorCodePrefixStyle],
      // /// but their styles will otherwise be kept as specified.
      // ///
      // /// Defaults to false.
      // final bool colorCodeHasColor;

      // /// Text style for the displayed generic color name in the picker.
      // ///
      // /// Defaults to `Theme.of(context).textTheme.bodyText2`, if not defined.
      // final TextStyle? colorCodeTextStyle;

      /// Old property, no longer in use. This property is now set via
      /// property [copyPasteBehavior] and [ColorPickerCopyPasteBehavior.copyIcon]
      /* 
      @Deprecated('This property is deprecated and no longer has any function. '
      'It was removed in v2.0.0. To modify the copy icon on the color code '
      'entry field, define the `ColorPickerCopyPasteBehavior(copyIcon: '
      'myIcon)` and provide it via the `copyPasteBehavior` property.')
      */
      colorCodeIcon: null,

      //      /// The TextStyle of the prefix of the color code.
      // ///
      // /// The prefix always include the alpha value and may also include a num char
      // /// '#' or '0x' based on the `ColorPickerCopyPasteBehavior.copyFormat`
      // /// setting.
      // ///
      // /// Defaults to [colorCodeTextStyle], if not defined.
      // final TextStyle? colorCodePrefixStyle;

      // /// When true, the color code field is always read only.
      // ///
      // /// If set to true, the color code field cannot be edited. Normally it can
      // /// be edited when used in a picker that can select and show any color.
      // /// Setting this to false makes it read only also on such pickers. This
      // /// currently only applies to the wheel picker, but will also apply to
      // /// future full color range pickers.
      // ///
      // /// Pickers that only offer a fixed palette, that you can just offered colors
      // /// from always have the color code field in read only mode, this setting
      // /// does not affect them.
      // ///
      // /// Regardless of the picker and [colorCodeReadOnly] value, you can change
      // /// color value by pasting in a new value, if your copy paste configuration
      // /// allows it.
      // ///
      // /// Defaults to false.
      // final bool colorCodeReadOnly;

      // /// Set to true to show the int [Color.value] of the selected [color].
      // ///
      // /// This is a developer feature, showing the int color value can be
      // /// useful during software development. If enabled the value is shown after
      // /// the color code. For text style it also uses the [colorCodeTextStyle].
      // /// There is no copy button for the shown int value, but the value is
      // /// displayed with a [SelectableText] widget, so it can be select painted
      // /// and copied if so required.
      // ///
      // /// Defaults to false.
      // final bool showColorValue;

      // /// Set to true to a list of recently selected colors selection at the bottom
      // /// of the picker.
      // ///
      // /// When `showRecentColors` is enabled, the color picker shows recently
      // /// selected colors in a list at the bottom of the color picker. The list
      // /// uses first-in, first-out to keep min 2 to max 20 colors (defaults to 5)
      // /// on the recently used colors list, the desired max value can be modified
      // /// with [maxRecentColors].
      // ///
      // /// Defaults to false.
      // final bool showRecentColors;

      // /// The maximum numbers of recent colors to show in the list of recent colors.
      // ///
      // /// The max recent colors must be from 2 to 20. Defaults to 5.
      // final int maxRecentColors;

      // /// A list with the recently select colors.
      // ///
      // /// Defaults to an empty list of colors. You can provide a starting
      // /// set from some stored state if so desired.
      // final List<Color> recentColors;

      // /// Optional callback that returns the current list of recently selected
      // /// colors.
      // ///
      // /// This optional callback is called every time a new color is added to the
      // /// recent colors list with the complete current list of recently used colors.
      // ///
      // /// If the optional callback is not provided, then it is not called. You can
      // /// use this callback to save and restore the recently used colors. To
      // /// initialize the list when the color picker is created give it a starting
      // /// via [recentColors]. This could be a list kept just in state during
      // /// the current app session, or it could have been persisted and restored
      // /// from a previous session.
      // final ValueChanged<List<Color>>? onRecentColorsChanged;

      // /// Set to true to enable all tooltips in this widget.
      // ///
      // /// When true, it enables all tooltips that are available in the color picker.
      // /// If the tooltips get in the way you can disable them all by setting this
      // /// property to `false`. Why not consider providing a setting in your app that
      // /// allows users to turn ON and OFF the tooltips in the app? FlexColorPicker
      // /// includes this toggle to make that easy to implement when it comes to its
      // /// tooltip behavior.
      // ///
      // /// Defaults to true.
      // final bool enableTooltips;

      // /// The color on the thumb of the slider that shows the selected picker type.
      // ///
      // /// If not defined, it defaults to `Color(0xFFFFFFFF)` (white) in light
      // /// theme and to `Color(0xFF636366)` in dark theme, which are the defaults
      // /// for the used [CupertinoSlidingSegmentedControl].
      // ///
      // /// If you give it a custom color, the color picker will automatically adjust
      // /// the text color on the selected thumb for best legible text contrast.
      // final Color? selectedPickerTypeColor;

      // /// The TextStyle of the labels in segmented color picker type selector.
      // ///
      // /// Defaults to `Theme.of(context).textTheme.caption`, if not defined.
      // final TextStyle? pickerTypeTextStyle;

      // /// A [ColorPickerType] to String map that contains labels for the picker
      // /// type selector.
      // ///
      // /// If not defined, or omitted in provided mpa, then the following default
      // /// English labels are used:
      // ///  * [ColorPickerType.both] : 'Both'
      // ///  * [ColorPickerType.primary] : 'Primary & Accent'
      // ///  * [ColorPickerType.accent] : 'Primary'
      // ///  * [ColorPickerType.bw] : 'Black & White'
      // ///  * [ColorPickerType.custom] : 'Custom'
      // ///  * [ColorPickerType.wheel] : 'Wheel'
      // final Map<ColorPickerType, String> pickerTypeLabels;

      // /// Color swatch to name map, with custom swatches and their names.
      // ///
      // /// Used to provide custom [ColorSwatch] objects to the custom color picker,
      // /// including their custom name label. These colors, their swatch shades
      // /// and names, are shown and used when the picker type
      // /// [ColorPickerType.custom] option is enabled in the color picker.
      // ///
      // /// Defaults to an empty map. If the map is empty, the custom colors picker
      // /// will not be shown even if it is enabled in [pickersEnabled].
      // final Map<ColorSwatch<Object>, String> customColorSwatchesAndNames;

      // /// English default label for picker with both primary and accent colors.
      // static const String _selectBothLabel = 'Primary & Accent';

      // /// English default label for picker with primary colors.
      // static const String _selectPrimaryLabel = 'Primary';

      // /// English default label for picker with accent colors.
      // static const String _selectAccentLabel = 'Accent';

      // /// English default label for picker with black and white shades.
      // static const String _selectBlackWhiteLabel = 'Black & White';

      // /// English default label for picker with custom defined colors.
      // static const String _selectCustomLabel = 'Custom';

      // /// English default label for the HSV wheel picker that can select any color.
      // static const String _selectWheelAnyLabel = 'Wheel';
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }
}
