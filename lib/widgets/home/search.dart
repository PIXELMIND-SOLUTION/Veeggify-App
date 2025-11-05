import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class SearchBarWithVoice extends StatefulWidget {
  const SearchBarWithVoice({super.key});

  @override
  State<SearchBarWithVoice> createState() => _SearchBarWithVoiceState();
}

class _SearchBarWithVoiceState extends State<SearchBarWithVoice>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  
  bool _isListening = false;
  String _recognizedText = '';
  bool _showSpeakPrompt = false;
  
  // Speech to text instance
  late stt.SpeechToText _speech;
  bool _speechAvailable = false;

  // Animation controllers for voice listening
  late AnimationController _pulseAnimationController;
  late Animation<double> _pulseAnimation;
  
  // Timer for showing "speak anything" prompt
  Timer? _silenceTimer;
  Timer? _autoCloseTimer;

  @override
  void initState() {
    super.initState();
    
    // Initialize speech to text
    _speech = stt.SpeechToText();
    _initializeSpeech();
    
    // Initialize pulse animation for listening state
    _pulseAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseAnimationController,
      curve: Curves.easeInOut,
    ));
  }
  
  Future<void> _initializeSpeech() async {
    try {
      _speechAvailable = await _speech.initialize(
        onError: (error) {
          print('Speech recognition error: $error');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Speech can not recogonise'),
                backgroundColor: const Color.fromARGB(255, 255, 88, 76),
              ),
            );
          }
        },
        onStatus: (status) {
          print('Speech status: $status');
        },
      );
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Failed to initialize speech recognition: $e');
      _speechAvailable = false;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _pulseAnimationController.dispose();
    _speech.stop();
    _silenceTimer?.cancel();
    _autoCloseTimer?.cancel();
    super.dispose();
  }
  
  void _startSilenceTimer() {
    _silenceTimer?.cancel();
    _autoCloseTimer?.cancel();
    
    // Show "speak anything" after 3 seconds
    _silenceTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _recognizedText.isEmpty && _isListening) {
        setState(() {
          _showSpeakPrompt = true;
        });
        
        // Auto-close after another 3 seconds if still nothing
        _autoCloseTimer = Timer(const Duration(seconds: 3), () {
          if (mounted && _recognizedText.isEmpty && _isListening) {
            Navigator.of(context).pop();
          }
        });
      }
    });
  }
  
  void _cancelTimers() {
    _silenceTimer?.cancel();
    _autoCloseTimer?.cancel();
  }

  Future<void> _showVoiceInputModal() async {
    // Check microphone permission
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Microphone permission is required for voice search'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (!_speechAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Speech recognition not available'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isListening = true;
      _recognizedText = '';
      _showSpeakPrompt = false;
    });
    
    // Start the silence timer
    _startSilenceTimer();

    // Start listening
    await _speech.listen(
      onResult: (result) {
        setState(() {
          _recognizedText = result.recognizedWords;
          // Reset timers and hide prompt when user starts speaking
          if (_recognizedText.isNotEmpty) {
            _showSpeakPrompt = false;
            _cancelTimers();
          }
        });
        
        // Auto-close when final result is received
        if (result.finalResult && _recognizedText.isNotEmpty) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted && _isListening) {
              Navigator.of(context).pop();
            }
          });
        }
      },
      listenMode: stt.ListenMode.confirmation,
      pauseFor: const Duration(seconds: 3),
      listenFor: const Duration(seconds: 30),
    );

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () async {
                      _cancelTimers();
                      await _speech.stop();
                      setState(() {
                        _isListening = false;
                        _showSpeakPrompt = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 24),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Listening text
                Text(
                  _showSpeakPrompt ? "Please speak anything..." : "Hi, I'm listening...",
                  style: TextStyle(
                    fontSize: 18,
                    color: _showSpeakPrompt ? Colors.orange : Colors.black87,
                    fontWeight: _showSpeakPrompt ? FontWeight.w600 : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                
                // Recognized text display
                Text(
                  _recognizedText.isEmpty ? '""' : '"$_recognizedText"',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                
                // Animated mic icon
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: _showSpeakPrompt ? Colors.orange : const Color(0xFFFF5722),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 60),
              ],
            ),
          );
        },
      ),
    ).whenComplete(() async {
      _cancelTimers();
      await _speech.stop();
      setState(() {
        _isListening = false;
        _showSpeakPrompt = false;
      });
      
      // Update search bar with recognized text and show search modal
      if (_recognizedText.isNotEmpty) {
        _searchController.text = _recognizedText;
        await _showSearchModal(context);
      }
    });
  }

  Future<void> _showSearchModal(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation1,
            curve: Curves.easeOut,
          )),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            autofocus: _searchController.text.isEmpty,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFEBF4F1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search for restaurants, dishes...",
                              hintStyle: const TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 0),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {});
                                      },
                                    )
                                  : null,
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            _showVoiceInputModal();
                          },
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.mic_none,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search, size: 50, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(
                            _searchController.text.isEmpty 
                                ? 'Start typing to search...'
                                : 'Searching for "${_searchController.text}"',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Connect your data source to see results',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    
    if (!_isListening) {
      _searchController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _showSearchModal(context),
            child: AbsorbPointer(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFEBF4F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search...",
                  hintStyle: const TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 102, 102, 102),
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: _showVoiceInputModal,
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mic_none,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}