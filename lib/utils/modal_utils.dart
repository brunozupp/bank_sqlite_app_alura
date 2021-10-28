import 'package:bank_sqlite_app_alura/styles/colors_app.dart';
import 'package:flutter/material.dart';

abstract class ModalUtils {

  static Future<String?> showModalGetAuthentication(BuildContext context) async {
    
    String value = "";
    
    return await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Autenticação"),
        content: TextField(
          maxLength: 4,
          obscureText: true,
          style: const TextStyle(
            fontSize: 64,
            letterSpacing: 8
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (val) => value = val,
          decoration: const InputDecoration(
            border: OutlineInputBorder()
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: const Text("Cancelar")
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(value), 
            child: const Text("Confirmar")
          )
        ],
      )
    );
  }

  static Future<bool?> showModalConfirmation(BuildContext context, {String? message}) async {
    return await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message ?? "Você confirma a ação?"),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true), 
                  child: const Text(
                    "Sim",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red 
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false), 
                  child: const Text(
                    "Não",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: ColorsApp.primaryColor 
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}