import 'package:flutter/material.dart';
import '../widgets/gradient_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
  TextEditingController(text: "My Restaurant");
  final TextEditingController phoneController =
  TextEditingController(text: "9999999999");
  final TextEditingController addressController =
  TextEditingController(text: "123 MG Road, Hyderabad");
  final TextEditingController descController =
  TextEditingController(text: "Serving quality food with love!");
  final TextEditingController openController =
  TextEditingController(text: "9:00 AM");
  final TextEditingController closeController =
  TextEditingController(text: "11:00 PM");

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.03),
            child: Column(
              children: [
                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(w * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.white, // Fully visible
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 6,
                              offset: const Offset(2, 2))
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.blue.shade900,
                        size: w * 0.07,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.03),

                // Profile Image with Camera
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: w * 0.18,
                      backgroundImage:
                      const AssetImage('assets/images/profile_placeholder.png'),
                      backgroundColor: Colors.white.withOpacity(0.25),
                    ),
                    Positioned(
                      bottom: w * 0.01,
                      right: w * 0.01,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                blurRadius: 5,
                                offset: const Offset(2, 2))
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            MdiIcons.cameraOutline,
                            color: Colors.blue.shade900,
                            size: w * 0.065,
                          ),
                          onPressed: () {
                            // Camera logic here
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.05),

                // Form Fields
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField("Restaurant Name", nameController,
                          icon: MdiIcons.storefront, w: w),
                      _buildTextField("Phone Number", phoneController,
                          keyboardType: TextInputType.phone,
                          icon: MdiIcons.phone,
                          w: w),
                      _buildTextField("Address", addressController,
                          icon: MdiIcons.mapMarker, w: w),
                      _buildTextField("Description", descController,
                          maxLines: 3, icon: MdiIcons.noteText, w: w),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField("Opens At", openController,
                                icon: MdiIcons.clockOutline, w: w),
                          ),
                          SizedBox(width: w * 0.03),
                          Expanded(
                            child: _buildTextField("Closes At", closeController,
                                icon: MdiIcons.clockOutline, w: w),
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.05),
                      GradientButton(
                        text: "Save Changes",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Profile Updated Successfully!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
        int maxLines = 1,
        required IconData icon,
        required double w}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: w * 0.018),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(color: Colors.white.withOpacity(0.98), fontSize: w * 0.045),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.95)),
          prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.95), size: w * 0.06),
          filled: true,
          fillColor: Colors.white.withOpacity(0.25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
      ),
    );
  }
}
