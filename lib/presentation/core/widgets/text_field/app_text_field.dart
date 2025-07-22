import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';
import 'package:smart_notes/presentation/core/widgets/text/material_app_text.dart';

/// Enum defining the different types of text fields available.
enum AppTextFieldType {
  /// A required field without a label
  required,

  /// An optional field without a label
  optional,

  /// A required field with a label and asterisk (*) indicator
  requiredWithLabel,

  /// An optional field with a label
  optionalWithLabel,
}

/// A highly customizable text field widget that provides consistent styling
/// and behavior across the application.
///
/// [AppTextField] supports various configurations including required/optional
/// fields, labels, validation, password fields, and extensive styling options.
/// It automatically handles focus management, error display, and character counting.
///
/// ## Factory Constructors
///
/// The widget provides four factory constructors for common use cases:
/// - [AppTextField.required]: Basic required field without label
/// - [AppTextField.optional]: Basic optional field without label
/// - [AppTextField.requiredWithLabel]: Required field with label and asterisk
/// - [AppTextField.optionalWithLabel]: Optional field with label
///
/// ## Basic Usage
///
/// ```dart
/// // Simple required field
/// AppTextField.required(
///   hintText: 'Enter your name',
///   validator: (value) => value?.isEmpty == true ? 'Name is required' : null,
/// )
///
/// // Field with label
/// AppTextField.requiredWithLabel(
///   label: 'Email Address',
///   hintText: 'Enter your email',
///   textInputType: TextInputType.emailAddress,
///   prefixIcon: Icons.email,
/// )
///
/// // Password field with visibility toggle
/// AppTextField.requiredWithLabel(
///   label: 'Password',
///   obscureText: true,
///   validator: (value) => value?.length < 6 ? 'Password too short' : null,
/// )
/// ```
///
/// ## Advanced Features
///
/// ### Validation
/// Supports built-in validation with automatic error display:
/// ```dart
/// AppTextField.required(
///   validator: (value) {
///     if (value?.isEmpty == true) return 'This field is required';
///     if (value!.length < 3) return 'Must be at least 3 characters';
///     return null;
///   },
///   autovalidateMode: AutovalidateMode.onUserInteraction,
/// )
/// ```
///
/// ### Character Counter
/// Display character count with maximum length:
/// ```dart
/// AppTextField.optional(
///   maxLength: 100,
///   showCounter: true,
///   hintText: 'Enter description (max 100 chars)',
/// )
/// ```
///
/// ### Custom Styling
/// Extensive styling options for borders, colors, and padding:
/// ```dart
/// AppTextField.required(
///   filled: true,
///   fillColor: Colors.grey[100],
///   borderRadius: 12.0,
///   borderColor: Colors.blue,
///   focusedBorderColor: Colors.blue[700],
///   contentPadding: EdgeInsets.all(16),
/// )
/// ```
///
/// See also:
/// * [TextFormField], which this widget wraps
/// * [InputDecoration], for understanding decoration options
/// * [TextInputFormatter], for input formatting
class AppTextField extends StatefulWidget {
  /// The label text displayed above the text field.
  ///
  /// Only used with [AppTextField.requiredWithLabel] and
  /// [AppTextField.optionalWithLabel] constructors.
  /// Required fields will show an asterisk (*) after the label.
  final String? label;

  /// Placeholder text shown when the field is empty.
  ///
  /// If not provided, defaults to 'Enter Value'.
  final String? hintText;

  /// Additional help text displayed below the field.
  ///
  /// Only shown when there's no error message. Useful for providing
  /// context or instructions to users.
  final String? helperText;

  /// Error message to display below the field.
  ///
  /// When provided, overrides any validator errors and helper text.
  /// Automatically styles the border and text in error colors.
  final String? errorText;

  /// The type of text field, determining its validation state and label behavior.
  final AppTextFieldType type;

  /// Controller for managing the text field's value.
  ///
  /// If not provided, the widget creates its own internal controller.
  /// Use this to programmatically set, clear, or read the field value.
  final TextEditingController? textEditingController;

  /// Callback called when the text value changes.
  ///
  /// Called with the new value every time the user types or deletes text.
  /// ```dart
  /// onValueChange: (value) => print('Current value: $value'),
  /// ```
  final Function(String?)? onValueChange;

  /// Callback called when the text field is tapped.
  ///
  /// Useful for showing date pickers, bottom sheets, or other UI elements
  /// when the field is interacted with.
  final VoidCallback? onTap;

  /// Callback called when editing is complete.
  ///
  /// Typically called when the user presses the done button on the keyboard
  /// or when focus is lost.
  final VoidCallback? onEditingComplete;

  /// Callback called when the user submits the field.
  ///
  /// Called with the current text value when the user presses the
  /// action button on the keyboard (e.g., "Done", "Next", "Search").
  final Function(String)? onFieldSubmitted;

  /// List of input formatters to apply to the text.
  ///
  /// Use this to restrict or format input, such as:
  /// - [FilteringTextInputFormatter.digitsOnly] for numbers only
  /// - [LengthLimitingTextInputFormatter] for character limits
  /// - Custom formatters for phone numbers, credit cards, etc.
  ///
  /// ```dart
  /// inputFormatters: [
  ///   FilteringTextInputFormatter.digitsOnly,
  ///   LengthLimitingTextInputFormatter(10),
  /// ],
  /// ```
  final List<TextInputFormatter>? inputFormatters;

  /// The type of keyboard to display.
  ///
  /// Common values:
  /// - [TextInputType.text] - Default text keyboard
  /// - [TextInputType.emailAddress] - Email keyboard with @ symbol
  /// - [TextInputType.phone] - Numeric keyboard for phone numbers
  /// - [TextInputType.number] - Numeric keyboard
  /// - [TextInputType.multiline] - Multiline text input
  final TextInputType? textInputType;

  /// Whether to hide the text being edited.
  ///
  /// When true, shows dots or asterisks instead of actual characters.
  /// Automatically adds a visibility toggle button as suffix icon.
  /// Perfect for password fields.
  final bool obscureText;

  /// Minimum number of lines for the text field.
  ///
  /// Useful for multiline text areas. The field will be at least this tall.
  final int? minLine;

  /// Maximum number of lines for the text field.
  ///
  /// When null, the field can expand infinitely. Set to 1 for single-line fields.
  /// For multiline text areas, set to a reasonable limit like 5 or 10.
  final int? maxLine;

  /// Maximum number of characters allowed.
  ///
  /// When set, prevents input beyond this limit and can show a character counter
  /// if [showCounter] is true.
  final int? maxLength;

  /// Whether the text field is enabled for interaction.
  ///
  /// When false, the field appears disabled and cannot be edited or focused.
  final bool enabled;

  /// Whether the text field is read-only.
  ///
  /// When true, the field can be focused and selected but not edited.
  /// Useful for displaying values that can be copied but not changed.
  final bool readOnly;

  /// Whether the text field should automatically receive focus.
  ///
  /// When true, the field will be focused when the widget is first built.
  final bool autofocus;

  /// Focus node for managing focus state.
  ///
  /// Use this to programmatically focus or unfocus the field,
  /// or to listen for focus changes.
  final FocusNode? focusNode;

  /// Validation function for the text field.
  ///
  /// Called with the current value and should return an error message string
  /// if invalid, or null if valid.
  ///
  /// ```dart
  /// validator: (value) {
  ///   if (value?.isEmpty == true) return 'This field is required';
  ///   if (!value!.contains('@')) return 'Please enter a valid email';
  ///   return null;
  /// },
  /// ```
  final String? Function(String?)? validator;

  /// How and when to validate the text field.
  ///
  /// - [AutovalidateMode.disabled] - Never validate automatically
  /// - [AutovalidateMode.always] - Validate on every change
  /// - [AutovalidateMode.onUserInteraction] - Validate after first interaction
  final AutovalidateMode? autovalidateMode;

  /// Icon to display at the beginning of the text field.
  ///
  /// Automatically styled with appropriate color and size.
  /// Cannot be used together with [prefixWidget].
  final IconData? prefixIcon;

  /// Custom widget to display at the beginning of the text field.
  ///
  /// Takes precedence over [prefixIcon] if both are provided.
  /// Use for complex prefix elements like avatars or custom icons.
  final Widget? prefixWidget;

  /// Icon to display at the end of the text field.
  ///
  /// Automatically styled and can be tapped if [onSuffixIconTap] is provided.
  /// Cannot be used together with [suffixWidget].
  /// Note: Ignored for password fields as they use built-in visibility toggle.
  final IconData? suffixIcon;

  /// Custom widget to display at the end of the text field.
  ///
  /// Takes precedence over [suffixIcon] if both are provided.
  /// Note: Ignored for password fields as they use built-in visibility toggle.
  final Widget? suffixWidget;

  /// Callback called when the suffix icon is tapped.
  ///
  /// Only works when [suffixIcon] is provided.
  final VoidCallback? onSuffixIconTap;

  /// Custom Text to display at the end of the user input.
  final String? suffixText;

  /// How to capitalize text input.
  ///
  /// - [TextCapitalization.none] - No automatic capitalization
  /// - [TextCapitalization.words] - Capitalize first letter of each word
  /// - [TextCapitalization.sentences] - Capitalize first letter of sentences
  /// - [TextCapitalization.characters] - Capitalize all characters
  final TextCapitalization textCapitalization;

  /// The action button to display on the keyboard.
  ///
  /// - [TextInputAction.done] - "Done" button (default)
  /// - [TextInputAction.next] - "Next" button for forms
  /// - [TextInputAction.search] - "Search" button
  /// - [TextInputAction.send] - "Send" button
  final TextInputAction? textInputAction;

  /// Whether to show character count when [maxLength] is set.
  ///
  /// Displays current length and maximum length in format "5/100".
  final bool showCounter;

  /// Internal padding for the text field content.
  ///
  /// Controls spacing between text and field borders.
  /// Defaults to symmetric padding of 12 pixels.
  final EdgeInsets? contentPadding;

  /// Background color when [filled] is true.
  ///
  /// Only visible when [filled] is set to true.
  /// Defaults to light grey if not specified.
  final Color? fillColor;

  /// Color of the text field border.
  ///
  /// Used for normal state. Overridden by error and focus colors
  /// in their respective states.
  final Color? borderColor;

  /// Color of the border when the field is focused.
  ///
  /// If not provided, uses the same color as [borderColor].
  final Color? focusedBorderColor;

  /// Color of the border when there's an error.
  ///
  /// Defaults to red if not specified.
  final Color? errorBorderColor;

  /// Corner radius for the text field border.
  ///
  /// Defaults to the app's default border radius if not specified.
  final double? borderRadius;

  /// Whether the text field should have a filled background.
  ///
  /// When true, fills the background with [fillColor].
  final bool filled;

  /// Private constructor used by all factory constructors.
  ///
  /// This constructor is not meant to be called directly.
  /// Use one of the factory constructors instead.
  const AppTextField._({
    required this.type,
    this.label,
    Key? key,
    this.hintText,
    this.helperText,
    this.errorText,
    this.textEditingController,
    this.onValueChange,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.minLine,
    this.maxLine,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.focusNode,
    this.validator,
    this.autovalidateMode,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixIcon,
    this.suffixWidget,
    this.suffixText,
    this.onSuffixIconTap,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.showCounter = false,
    this.contentPadding,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderRadius,
    this.filled = false,
  }) : super(key: key);

  /// Creates a required text field without a label.
  ///
  /// This is the most basic required field configuration. The field will
  /// be marked as required for validation purposes but won't show a label.
  ///
  /// Example:
  /// ```dart
  /// AppTextField.required(
  ///   hintText: 'Enter your name',
  ///   validator: (value) => value?.isEmpty == true ? 'Name is required' : null,
  ///   prefixIcon: Icons.person,
  /// )
  /// ```
  ///
  /// All parameters except factory-specific ones are supported.
  factory AppTextField.required({
    String? hintText,
    String? helperText,
    String? errorText,
    TextEditingController? textEditingController,
    Function(String?)? onValueChange,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    Function(String)? onFieldSubmitted,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? textInputType,
    bool obscureText = false,
    int? minLine,
    int? maxLine,
    int? maxLength,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.always,
    IconData? prefixIcon,
    Widget? prefixWidget,
    IconData? suffixIcon,
    Widget? suffixWidget,
    VoidCallback? onSuffixIconTap,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    bool showCounter = false,
    EdgeInsets? contentPadding,
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderRadius,
    bool filled = false,
    String? suffixText,
  }) {
    return AppTextField._(
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      type: AppTextFieldType.required,
      textEditingController: textEditingController,
      onValueChange: onValueChange,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      textInputType: textInputType,
      obscureText: obscureText,
      minLine: minLine,
      maxLine: maxLine,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      focusNode: focusNode,
      validator: validator,
      autovalidateMode: autovalidateMode,
      prefixIcon: prefixIcon,
      prefixWidget: prefixWidget,
      suffixIcon: suffixIcon,
      suffixWidget: suffixWidget,
      onSuffixIconTap: onSuffixIconTap,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      showCounter: showCounter,
      contentPadding: contentPadding,
      fillColor: fillColor,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderRadius: borderRadius,
      filled: filled,
      suffixText: suffixText,
    );
  }

  /// Creates an optional text field without a label.
  ///
  /// This is the most basic optional field configuration. The field will
  /// be marked as optional for validation purposes but won't show a label.
  ///
  /// Example:
  /// ```dart
  /// AppTextField.optional(
  ///   hintText: 'Additional comments (optional)',
  ///   maxLine: 3,
  ///   maxLength: 200,
  /// )
  /// ```
  ///
  /// All parameters except factory-specific ones are supported.
  factory AppTextField.optional({
    String? hintText,
    String? helperText,
    String? errorText,
    TextEditingController? textEditingController,
    Function(String?)? onValueChange,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    Function(String)? onFieldSubmitted,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? textInputType,
    bool obscureText = false,
    int? minLine,
    int? maxLine,
    int? maxLength,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode = AutovalidateMode.always,
    IconData? prefixIcon,
    Widget? prefixWidget,
    IconData? suffixIcon,
    Widget? suffixWidget,
    VoidCallback? onSuffixIconTap,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    bool showCounter = false,
    EdgeInsets? contentPadding,
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderRadius,
    bool filled = false,
    String? suffixText,
  }) {
    return AppTextField._(
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      type: AppTextFieldType.optional,
      textEditingController: textEditingController,
      onValueChange: onValueChange,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      textInputType: textInputType,
      obscureText: obscureText,
      minLine: minLine,
      maxLine: maxLine,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      focusNode: focusNode,
      validator: validator,
      autovalidateMode: autovalidateMode,
      prefixIcon: prefixIcon,
      prefixWidget: prefixWidget,
      suffixIcon: suffixIcon,
      suffixWidget: suffixWidget,
      onSuffixIconTap: onSuffixIconTap,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      showCounter: showCounter,
      contentPadding: contentPadding,
      fillColor: fillColor,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderRadius: borderRadius,
      filled: filled,
      suffixText: suffixText,
    );
  }

  /// Creates a required text field with a label.
  ///
  /// Displays a label above the text field with an asterisk (*) to indicate
  /// the field is required. Perfect for forms and structured input.
  ///
  /// Example:
  /// ```dart
  /// AppTextField.requiredWithLabel(
  ///   label: 'Email Address',
  ///   hintText: 'Enter your email',
  ///   textInputType: TextInputType.emailAddress,
  ///   validator: (value) {
  ///     if (value?.isEmpty == true) return 'Email is required';
  ///     return null;
  ///   },
  ///   prefixIcon: Icons.email,
  /// )
  /// ```
  ///
  /// The [label] parameter is required for this constructor.
  factory AppTextField.requiredWithLabel({
    required String label,
    String? hintText,
    String? helperText,
    String? errorText,
    TextEditingController? textEditingController,
    Function(String?)? onValueChange,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    Function(String)? onFieldSubmitted,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? textInputType,
    bool obscureText = false,
    int? minLine,
    int? maxLine,
    int? maxLength,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode = AutovalidateMode.always,
    IconData? prefixIcon,
    Widget? prefixWidget,
    IconData? suffixIcon,
    Widget? suffixWidget,
    VoidCallback? onSuffixIconTap,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    bool showCounter = false,
    EdgeInsets? contentPadding,
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderRadius,
    bool filled = false,
    String? suffixText,
  }) {
    return AppTextField._(
      label: label,
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      type: AppTextFieldType.requiredWithLabel,
      textEditingController: textEditingController,
      onValueChange: onValueChange,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      textInputType: textInputType,
      obscureText: obscureText,
      minLine: minLine,
      maxLine: maxLine,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      focusNode: focusNode,
      validator: validator,
      autovalidateMode: autovalidateMode,
      prefixIcon: prefixIcon,
      prefixWidget: prefixWidget,
      suffixIcon: suffixIcon,
      suffixWidget: suffixWidget,
      onSuffixIconTap: onSuffixIconTap,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      showCounter: showCounter,
      contentPadding: contentPadding,
      fillColor: fillColor,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderRadius: borderRadius,
      filled: filled,
      suffixText: suffixText,
    );
  }

  /// Creates an optional text field with a label.
  ///
  /// Displays a label above the text field without any required indicator.
  /// Perfect for optional form fields that benefit from clear labeling.
  ///
  /// Example:
  /// ```dart
  /// AppTextField.optionalWithLabel(
  ///   label: 'Phone Number',
  ///   hintText: 'Enter your phone number',
  ///   textInputType: TextInputType.phone,
  ///   helperText: 'We\'ll only use this to contact you about your order',
  ///   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  /// )
  /// ```
  ///
  /// The [label] parameter is required for this constructor.
  factory AppTextField.optionalWithLabel({
    required String label,
    String? hintText,
    String? helperText,
    String? errorText,
    TextEditingController? textEditingController,
    Function(String?)? onValueChange,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    Function(String)? onFieldSubmitted,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? textInputType,
    bool obscureText = false,
    int? minLine,
    int? maxLine,
    int? maxLength,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode = AutovalidateMode.always,
    IconData? prefixIcon,
    Widget? prefixWidget,
    IconData? suffixIcon,
    Widget? suffixWidget,
    VoidCallback? onSuffixIconTap,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    bool showCounter = false,
    EdgeInsets? contentPadding,
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderRadius,
    bool filled = false,
    String? suffixText,
  }) {
    return AppTextField._(
      label: label,
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      type: AppTextFieldType.optionalWithLabel,
      textEditingController: textEditingController,
      onValueChange: onValueChange,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      textInputType: textInputType,
      obscureText: obscureText,
      minLine: minLine,
      maxLine: maxLine,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      focusNode: focusNode,
      validator: validator,
      autovalidateMode: autovalidateMode,
      prefixIcon: prefixIcon,
      prefixWidget: prefixWidget,
      suffixIcon: suffixIcon,
      suffixWidget: suffixWidget,
      onSuffixIconTap: onSuffixIconTap,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      showCounter: showCounter,
      contentPadding: contentPadding,
      fillColor: fillColor,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderRadius: borderRadius,
      filled: filled,
      suffixText: suffixText,
    );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

/// Internal state class for [AppTextField].
///
/// Manages the widget's mutable state including obscure text toggle,
/// error text display, and character counting.
class _AppTextFieldState extends State<AppTextField> {
  /// Current obscure text state (for password fields)
  late bool _obscureText;

  /// Current error text to display
  String? _errorText;

  /// Current character count for counter display
  int _currentLength = 0;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _errorText = widget.errorText;
    _currentLength = widget.textEditingController?.text.length ?? 0;
    widget.textEditingController?.addListener(_updateCounter);
  }

  /// Updates the character counter when text changes
  void _updateCounter() {
    if (mounted) {
      setState(() {
        _currentLength = widget.textEditingController?.text.length ?? 0;
      });
    }
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      _errorText = widget.errorText;
    }
    if (widget.textEditingController != oldWidget.textEditingController) {
      oldWidget.textEditingController?.removeListener(_updateCounter);
      widget.textEditingController?.addListener(_updateCounter);
      _currentLength = widget.textEditingController?.text.length ?? 0;
    }
  }

  @override
  void dispose() {
    widget.textEditingController?.removeListener(_updateCounter);
    super.dispose();
  }

  /// Toggles password visibility for obscure text fields
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  /// Builds the prefix icon widget
  Widget? _buildPrefixIcon() {
    if (widget.prefixWidget != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w8),
        child: widget.prefixWidget,
      );
    }
    if (widget.prefixIcon != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w8),
        child: Icon(
          widget.prefixIcon,
          color: context.colors.splashColor,
          size: context.w16,
        ),
      );
    }
    return null;
  }

  /// Builds the suffix icon widget with special handling for password fields
  Widget? _buildSuffixIcon() {
    if (widget.suffixWidget != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w8),
        child: widget.suffixWidget,
      );
    }

    if (widget.obscureText) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w8),
        child: GestureDetector(
          onTap: _toggleObscureText,
          child: Icon(
            _obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: context.colors.primary,
            size: context.w16,
          ),
        ),
      );
    }

    if (widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onSuffixIconTap,
        child: Icon(
          widget.suffixIcon,
          color: context.colors.splashColor,
          size: context.w20,
        ),
      );
    }
    return null;
  }

  /// Determines the appropriate border color based on current state
  Color _getBorderColor() {
    if (_errorText != null) {
      return widget.errorBorderColor ?? Colors.red;
    }
    return FocusScope.of(context).hasFocus
        ? widget.focusedBorderColor ??
            widget.borderColor ??
            context.colors.dividerColor
        : widget.borderColor ?? context.colors.dividerColor;
  }

  /// Builds the label row with required indicator if needed
  Widget _buildLabelRow(bool isRequired) {
    if (widget.label == null) return const SizedBox.shrink();

    return Padding(
      padding:
          AppUiConstants.defaultTextFieldHorizontalPadding.copyWith(bottom: 6),
      child: Row(
        children: [
          MaterialAppText.labelMedium(widget.label!),
          if (isRequired)
            MaterialAppText.labelMedium(
              ' *',
              color: Colors.redAccent,
            ),
        ],
      ),
    );
  }

  /// Builds the helper text widget displayed below the field
  Widget _buildHelperText() {
    return Padding(
      padding: AppUiConstants.defaultTextFieldInputHorizontalPadding
          .copyWith(top: context.w8),
      child: MaterialAppText.bodySmall(
        widget.helperText!,
        color: Colors.grey[600],
      ),
    );
  }

  /// Builds the error text widget displayed below the field
  Widget _buildErrorText() {
    return Padding(
      padding: AppUiConstants.defaultTextFieldInputHorizontalPadding
          .copyWith(top: context.w8),
      child: MaterialAppText.bodySmall(
        _errorText!,
        color: context.danger,
      ),
    );
  }

  /// Builds the character counter text widget
  Widget _buildCounterText() {
    return Padding(
      padding: AppUiConstants.defaultTextFieldInputHorizontalPadding
          .copyWith(top: context.w8),
      child: Align(
        alignment: Alignment.centerRight,
        child: MaterialAppText.bodySmall(
          '$_currentLength/${widget.maxLength}',
          color: Colors.grey[600],
        ),
      ),
    );
  }

  /// Builds the input decoration for the text field
  InputDecoration _buildDecoration() {
    return InputDecoration(
      hintText: widget.hintText ?? 'Enter Value',
      hintStyle: context.materialTextStyles.bodyMedium.copyWith(
        fontSize: _scalableTextSize(14, context),
        color: Colors.grey,
      ),
      border: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      // FIX 1: Adjust content padding for better vertical centering
      contentPadding: widget.contentPadding ??
          EdgeInsets.symmetric(
            vertical: context.h12, // Reduced from h16 to h12
            horizontal: context.w12,
          ),
      // FIX 2: Ensure icons are properly constrained
      prefixIcon: _buildPrefixIcon(),
      prefixIconConstraints: BoxConstraints(
        minWidth: context.customWidth(40),
        minHeight: context.customWidth(40),
      ),
      suffixIcon: _buildSuffixIcon(),
      suffixIconConstraints: BoxConstraints(
        minWidth: context.customWidth(40),
        minHeight: context.customWidth(40),
      ),
      suffixText: widget.suffixText,
      suffixStyle: context.materialTextStyles.bodyMedium.copyWith(
        fontSize: _scalableTextSize(14, context),
      ),
      errorStyle: const TextStyle(
        fontSize: 0.1,
        height: 0,
        color: Colors.transparent,
      ),
      helperStyle: const TextStyle(
        height: 0,
      ),
      // FIX 3: Add this to ensure proper alignment
      isDense: true,
      isCollapsed: false, // Keep as false for proper icon spacing
      // Remove any default spacing
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }

  double? _scalableTextSize(double? size, BuildContext context) {
    if (size == null) return null;

    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    final devicePixelRatio = mediaQueryData.devicePixelRatio;
    final aspectRatio = screenWidth / screenHeight;
    const designWidth = 390;
    const designHeight = 850;

    final scaleW = size * screenWidth / designWidth;
    final scaleH = size * screenHeight / designHeight;
    final densityBoost = devicePixelRatio * aspectRatio;

    return (scaleW + scaleH + densityBoost) / 2.4;
  }

  /// Builds the container decoration with border and background
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: widget.filled ? (widget.fillColor ?? Colors.white) : null,
      border: Border.all(
        color: _getBorderColor(),
        width: _errorText != null ? 2 : 1,
      ),
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? AppUiConstants.defaultBorderRadius ?? 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRequired = widget.type == AppTextFieldType.required ||
        widget.type == AppTextFieldType.requiredWithLabel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with required indicator
        _buildLabelRow(isRequired),

        // Main text field container
        Container(
          constraints: BoxConstraints(
            maxHeight: context.customWidth(48),
          ),
          decoration: _buildBoxDecoration(),
          child: IntrinsicHeight(
            child: TextFormField(
              style: context.materialTextStyles.bodyMedium.copyWith(
                fontSize: _scalableTextSize(16, context),
                height: 1.4
              ),
              cursorColor: context.colors.primary,
              cursorErrorColor: context.colors.primary,
              controller: widget.textEditingController,
              focusNode: widget.focusNode,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              autofocus: widget.autofocus,
              decoration: _buildDecoration(),
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.textInputType,
              textCapitalization: widget.textCapitalization,
              textInputAction: widget.textInputAction ?? TextInputAction.done,
              onChanged: widget.onValueChange,
              onTap: widget.onTap,
              onEditingComplete: widget.onEditingComplete,
              onFieldSubmitted: widget.onFieldSubmitted,
              validator: (value) {
                final error = widget.validator?.call(value);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && _errorText != error) {
                    setState(() {
                      _errorText = error;
                    });
                  }
                });
                return error;
              },
              autovalidateMode: widget.autovalidateMode,
              enableSuggestions: !widget.obscureText,
              autocorrect: !widget.obscureText,
              obscureText: _obscureText,
              minLines: widget.minLine ?? 1,
              maxLines: widget.maxLine ?? widget.minLine ?? 1,
              maxLength: widget.maxLength,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
            ),
          ),
        ),

        // Helper text (shown when no error)
        if (widget.helperText != null && _errorText == null) _buildHelperText(),

        // Error text (takes precedence over helper text)
        if (_errorText != null) _buildErrorText(),

        // Character counter
        if (widget.showCounter && widget.maxLength != null) _buildCounterText(),
      ],
    );
  }
}
