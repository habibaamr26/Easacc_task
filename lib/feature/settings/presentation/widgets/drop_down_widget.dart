

import 'package:easacc_task/core/utils/app_text.dart';
import 'package:easacc_task/core/utils/text_style.dart';
import 'package:easacc_task/feature/settings/data/models/devices_model.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class DropDownWidget extends StatefulWidget {
  late List<Device> devices;
   DropDownWidget({super.key, required this.devices});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
 Device? selectedDevice;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.devices.isNotEmpty) {
    selectedDevice = widget.devices.first; 
  }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      AppText.selectDevice,
                      style:AppTextStyle.textStyleSemiBold18,
                    ),
                    const Spacer(),
                    Text(
                      '${widget.devices.length} found',
                      style: AppTextStyle.textStyleRegular12,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<Device>(
                  initialValue: widget.devices.contains(selectedDevice) ? selectedDevice : null,
                  isExpanded: true,
                  items: widget.devices
                      .map(
                        (device) => DropdownMenuItem(
                          value: device,
                          child: Row(
                            children: [
                              Icon(
                                device.type == DeviceType.wifi
                                    ? Icons.wifi
                                    : Icons.bluetooth,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${device.name} (${device.type.name})',
                                  style: AppTextStyle.textStyleRegular16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDevice = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: AppText.selectDevice,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.devices),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppText.autoRefreshInfo,
                  style: AppTextStyle.textStyleRegular12.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          );
  }
}