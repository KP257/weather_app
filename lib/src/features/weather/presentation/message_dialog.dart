import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageDialog
{
  static Future<void> showErrorMessage(BuildContext context, String title, String message) async {
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            dialogDecoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            type: ArtSweetAlertType.danger,
            confirmButtonColor: Theme.of(context).primaryColor,
            title: title,
            text: message
        )
    );

  }
  static Future<void> showLoadingDialog(BuildContext context, String message) async {

    double height = MediaQuery.of(context).size.height;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: height / 2,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),

                const SizedBox(height: 20.0),
                Text(
                  "Loading...",
                  style: GoogleFonts.poppins(
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                    color: Theme.of(context).textTheme.titleLarge!.color,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "$message...",
                  style: GoogleFonts.poppins(
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15.0), // Add space

              ],
            ),
          ),
        );
      },
    );

  }
}