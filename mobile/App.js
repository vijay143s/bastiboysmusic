import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { GestureHandlerRootView } from 'react-native-gesture-handler';
import Toast from 'react-native-toast-message';
import { UserProvider } from './src/context/User';
import { SongProvider } from './src/context/Song';
import { LanguageProvider } from './src/context/Language';
import AppNavigator from './src/navigation/AppNavigator';
import Loading from './src/components/Loading';

export default function App() {
    return (
        <GestureHandlerRootView style={{ flex: 1 }}>
            <LanguageProvider>
                <UserProvider>
                    <SongProvider>
                        <StatusBar style="light" />
                        <AppNavigator />
                        <Toast />
                    </SongProvider>
                </UserProvider>
            </LanguageProvider>
        </GestureHandlerRootView>
    );
}
