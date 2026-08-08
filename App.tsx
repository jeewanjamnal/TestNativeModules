
import { Alert, Button, StatusBar, StyleSheet, useColorScheme, View } from 'react-native';
import {
  SafeAreaProvider,
} from 'react-native-safe-area-context';
import NativeBatteryModule from './specs/NativeBatteryModule';

function App() {
  const isDarkMode = useColorScheme() === 'dark';

  return (
    <SafeAreaProvider>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />
      <AppContent />
    </SafeAreaProvider>
  );
}

function AppContent() {
  async function loginWithBiometrics() {

    try {

      const available =
        await NativeBatteryModule.getBatteryLevel();

      Alert.alert(
          'alert',
          available.toString()
        );

    } catch (error) {

      Alert.alert(
        'Error',
        String(error)
      );

    }

  }

  return (
    <View style={styles.container}>
      <Button
        title="Authenticate"
        onPress={loginWithBiometrics}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default App;
