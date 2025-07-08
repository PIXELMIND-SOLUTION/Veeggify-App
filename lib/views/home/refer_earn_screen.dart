import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ReferEarnScreen extends StatelessWidget {
  const ReferEarnScreen({super.key});

  final String inviteCode = "HGT9LL8MEE";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invite your friends",style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
          
            Image.network(
              'https://s3-alpha-sig.figma.com/img/41df/41e3/2c242f868529f7f8220236825428735b?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=CzgJYo5x11wcMv3wm66r~6~JLNTl5IkVcReMNMSTxuxKJnZ8s6Q8bcXbmW6zIl~a-hCJyOA65KGm2VqZ12D0ecc0XbZ7UYC~kZkkiPjFEZzvgtWDFYFp~0kDeY92VlHxvZR-n7YXEXQS01IadmvWxIRzTZWEtMER1u9zJDTXpZiYh6-rwYgMiARjupWLedmcJynSjkjFjlmdQbBARNn1-bNJykzr-jGtKt2BoKcJU0y~5DWqQ8mYXRvH8kimyFPumgn3KsjrsMIw7dEkGQwBnLcNyLZa57q9r2~YNGW3syj0UW72~O79T3OHQRCHPmpf6TJvOSsu27m4WzEB1lwcKQ__', 
              height: 200,
              width: double.infinity,
            ),
            const SizedBox(height: 24),
            const Text(
              "Earn a free car",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Did you know you can earn up to AED 3000 by referring 10 friends in a month? That’s equal to a month subscription.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8),
                color: Colors.green.shade50,
              ),
              child: Text(
                inviteCode,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: inviteCode));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invite code copied!")),
                    );
                  },
                  child: const Text("Copy invite code",style: TextStyle(color: Colors.green),),
                ),
                ElevatedButton(
                  onPressed: () {
                    Share.share("Use my invite code $inviteCode to earn rewards!");
                  },
                  child: const Text("Share invite code",style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
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
