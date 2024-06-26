import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSlider extends StatefulWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onMaxChanged;
  final ValueChanged<double> onMinChanged;
  final bool hasMin;

  const CustomSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.onMaxChanged,
    required this.onMinChanged,
    this.hasMin = true,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late TextEditingController _maxController;
  late TextEditingController _minController;
  bool isUpdated = false;
  String? maxErrorText;
  String? minErrorText;
  late double sliderValue;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildSmallScreen();
          } else {
            return _buildWideScreen();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _maxController.dispose();
    _minController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _maxController = TextEditingController(text: widget.max.toString());
    _minController = TextEditingController(text: widget.min.toString());
    sliderValue = widget.value.clamp(widget.min, widget.max);
  }

  Widget _buildLabelWithIcon() {
    return Row(
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        IconButton(
          icon: Icon(isUpdated ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          onPressed: () {
            setState(() {
              isUpdated = !isUpdated;
            });
          },
        ),
      ],
    );
  }

  Widget _buildMinMaxField({
    required TextEditingController controller,
    required String label,
    required ValueChanged<String> onChanged,
    String? errorText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*$'))
      ],
      keyboardType: TextInputType.number,
      onChanged: onChanged,
    );
  }

  Widget _buildMinMaxFields() {
    return Column(
      children: [
        if (widget.hasMin) ...[
          _buildMinMaxField(
            controller: _minController,
            label: 'Min',
            onChanged: (value) {
              double minValue = double.tryParse(value) ?? widget.min;
              if (minValue >= widget.max) {
                setState(() {
                  minErrorText = 'Min cannot be greater than or equal to Max';
                });
              } else {
                setState(() {
                  minErrorText = null;
                });
                widget.onMinChanged(minValue);
                _updateSliderValue();
              }
            },
            errorText: minErrorText,
          ),
          const SizedBox(height: 10),
        ],
        _buildMinMaxField(
          controller: _maxController,
          label: 'Max',
          onChanged: (value) {
            double maxValue = double.tryParse(value) ?? widget.max;
            if (maxValue <= widget.min) {
              setState(() {
                maxErrorText = 'Max cannot be less than or equal to Min';
              });
            } else {
              setState(() {
                maxErrorText = null;
              });
              widget.onMaxChanged(maxValue);
              _updateSliderValue();
            }
          },
          errorText: maxErrorText,
        ),
      ],
    );
  }

  Widget _buildSliderWithValue() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Slider(
            value: sliderValue,
            min: widget.min,
            max: widget.max,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
              widget.onChanged(value);
            },
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(sliderValue.toStringAsFixed(1)),
        ),
      ],
    );
  }

  Widget _buildSmallScreen() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildLabelWithIcon(),
        _buildSliderWithValue(),
        if (isUpdated) _buildMinMaxFields(),
      ],
    );
  }

  Widget _buildWideScreen() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: Text(widget.label)),
        Expanded(
          flex: 5,
          child: Slider(
            value: sliderValue,
            min: widget.min,
            max: widget.max,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
              widget.onChanged(value);
            },
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(sliderValue.toStringAsFixed(1)),
        ),
        IconButton(
          icon: Icon(isUpdated ? Icons.check : Icons.edit),
          onPressed: () {
            setState(() {
              isUpdated = !isUpdated;
            });
          },
        ),
        if (isUpdated)
          Expanded(
            flex: 2,
            child: _buildMinMaxFields(),
          ),
      ],
    );
  }

  void _updateSliderValue() {
    setState(() {
      sliderValue = sliderValue.clamp(widget.min, widget.max);
    });
  }
}
