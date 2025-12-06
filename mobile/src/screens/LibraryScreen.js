import React from 'react';
import {
    View,
    Text,
    StyleSheet,
    TouchableOpacity,
    ScrollView,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { UserData } from '../context/User';
import { useLanguage } from '../context/Language';
import { COLORS, SIZES } from '../constants';
import MiniPlayer from '../components/MiniPlayer';

const LibraryScreen = ({ navigation }) => {
    const { user } = UserData();

    const menuItems = [
        { icon: 'heart', title: 'Liked Songs', subtitle: 'Your favorite tracks', screen: 'Playlist' },
        { icon: 'time', title: 'Recently Played', subtitle: 'Your listening history', screen: 'Playlist' },
        { icon: 'albums', title: 'Albums', subtitle: 'Browse all albums', screen: 'Albums' },
        { icon: 'person', title: 'Artists', subtitle: 'Browse all artists', screen: 'Artists' },
    ];

    return (
        <SafeAreaView style={styles.container} edges={['top']}>
            <View style={styles.header}>
                <Text style={styles.title}>Your Library</Text>
            </View>

            <ScrollView style={styles.content}>
                {menuItems.map((item, index) => (
                    <TouchableOpacity
                        key={index}
                        style={styles.menuItem}
                        onPress={() => navigation.navigate(item.screen)}
                    >
                        <View style={styles.iconContainer}>
                            <Ionicons name={item.icon} size={24} color={COLORS.primary} />
                        </View>
                        <View style={styles.menuInfo}>
                            <Text style={styles.menuTitle}>{item.title}</Text>
                            <Text style={styles.menuSubtitle}>{item.subtitle}</Text>
                        </View>
                        <Ionicons name="chevron-forward" size={20} color={COLORS.textSecondary} />
                    </TouchableOpacity>
                ))}
            </ScrollView>

            <MiniPlayer navigation={navigation} />
        </SafeAreaView>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: COLORS.background,
    },
    header: {
        paddingHorizontal: SIZES.padding,
        paddingVertical: SIZES.padding,
    },
    title: {
        fontSize: 28,
        fontWeight: 'bold',
        color: COLORS.text,
    },
    content: {
        flex: 1,
    },
    menuItem: {
        flexDirection: 'row',
        alignItems: 'center',
        paddingHorizontal: SIZES.padding,
        paddingVertical: 16,
        borderBottomWidth: 1,
        borderBottomColor: COLORS.border,
    },
    iconContainer: {
        width: 50,
        height: 50,
        borderRadius: 25,
        backgroundColor: COLORS.card,
        justifyContent: 'center',
        alignItems: 'center',
        marginRight: 16,
    },
    menuInfo: {
        flex: 1,
    },
    menuTitle: {
        fontSize: 16,
        fontWeight: '600',
        color: COLORS.text,
        marginBottom: 4,
    },
    menuSubtitle: {
        fontSize: 14,
        color: COLORS.textSecondary,
    },
});

export default LibraryScreen;
