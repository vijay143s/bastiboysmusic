import React, { createContext, useContext, useState, useEffect } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';

const LanguageContext = createContext();

const AVAILABLE_LANGUAGES = [
    { code: 'telugu', name: 'Telugu', native: 'తెలుగు' },
    { code: 'hindi', name: 'Hindi', native: 'हिन्दी' },
    { code: 'tamil', name: 'Tamil', native: 'தமிழ்' },
    { code: 'kannada', name: 'Kannada', native: 'ಕನ್ನಡ' },
    { code: 'malayalam', name: 'Malayalam', native: 'മലയാളം' },
];

export const LanguageProvider = ({ children }) => {
    const [selectedLanguage, setSelectedLanguage] = useState('telugu');
    const [loading, setLoading] = useState(true);

    // Load saved language preference
    useEffect(() => {
        loadLanguagePreference();
    }, []);

    const loadLanguagePreference = async () => {
        try {
            const saved = await AsyncStorage.getItem('selectedLanguage');
            if (saved) {
                setSelectedLanguage(saved);
            }
        } catch (error) {
            console.error('Error loading language preference:', error);
        } finally {
            setLoading(false);
        }
    };

    const changeLanguage = async (languageCode) => {
        try {
            await AsyncStorage.setItem('selectedLanguage', languageCode);
            setSelectedLanguage(languageCode);
        } catch (error) {
            console.error('Error saving language preference:', error);
        }
    };

    return (
        <LanguageContext.Provider
            value={{
                selectedLanguage,
                changeLanguage,
                availableLanguages: AVAILABLE_LANGUAGES,
                loading,
            }}
        >
            {children}
        </LanguageContext.Provider>
    );
};

export const useLanguage = () => useContext(LanguageContext);
