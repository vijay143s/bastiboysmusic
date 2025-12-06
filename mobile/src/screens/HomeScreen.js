import React, { useEffect } from 'react';
import {
    View,
    Text,
    StyleSheet,
    FlatList,
    TouchableOpacity,
    Image,
    ScrollView,
    RefreshControl,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { SongData } from '../context/Song';
import { UserData } from '../context/User';
import { COLORS, SIZES } from '../constants';
import MiniPlayer from '../components/MiniPlayer';

const HomeScreen = ({ navigation }) => {
    const { songs, fetchSongs, playQueue } = SongData();
    const { user } = UserData();
    const [refreshing, setRefreshing] = React.useState(false);

    useEffect(() => {
        fetchSongs();
    }, []);

    const onRefresh = async () => {
        setRefreshing(true);
        await fetchSongs();
        setRefreshing(false);
    };

    const handleSongPress = (song) => {
        playQueue(songs, song._id, 'All Songs');
    };

    const renderSongItem = ({ item }) => (
        <TouchableOpacity
            style={styles.songCard}
            onPress={() => handleSongPress(item)}
        >
            <Image
                source={{ uri: item.thumbnail?.url || 'https://via.placeholder.com/60' }}
                style={styles.songImage}
            />
            <View style={styles.songInfo}>
                <Text style={styles.songTitle} numberOfLines={1}>
                    {item.title}
                </Text>
                <Text style={styles.songArtist} numberOfLines={1}>
                    {item.singer || 'Unknown Artist'}
                </Text>
            </View>
            <TouchableOpacity>
                <Ionicons name="ellipsis-vertical" size={20} color={COLORS.textSecondary} />
            </TouchableOpacity>
        </TouchableOpacity>
    );

    return (
        <SafeAreaView style={styles.container} edges={['top']}>
            <View style={styles.header}>
                <Text style={styles.greeting}>Hello, {user?.name || 'Guest'}!</Text>
                <TouchableOpacity onPress={() => navigation.navigate('Queue')}>
                    <Ionicons name="list" size={24} color={COLORS.text} />
                </TouchableOpacity>
            </View>

            <ScrollView
                style={styles.content}
                refreshControl={
                    <RefreshControl refreshing={refreshing} onRefresh={onRefresh} tintColor={COLORS.primary} />
                }
            >
                <View style={styles.section}>
                    <Text style={styles.sectionTitle}>Trending Now</Text>
                    <FlatList
                        data={songs.slice(0, 20)}
                        renderItem={renderSongItem}
                        keyExtractor={(item) => item._id}
                        scrollEnabled={false}
                    />
                </View>
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
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        paddingHorizontal: SIZES.padding,
        paddingVertical: SIZES.padding,
    },
    greeting: {
        fontSize: 24,
        fontWeight: 'bold',
        color: COLORS.text,
    },
    content: {
        flex: 1,
    },
    section: {
        marginBottom: 24,
    },
    sectionTitle: {
        fontSize: 20,
        fontWeight: 'bold',
        color: COLORS.text,
        paddingHorizontal: SIZES.padding,
        marginBottom: 12,
    },
    songCard: {
        flexDirection: 'row',
        alignItems: 'center',
        paddingHorizontal: SIZES.padding,
        paddingVertical: 8,
    },
    songImage: {
        width: 60,
        height: 60,
        borderRadius: 8,
        backgroundColor: COLORS.card,
    },
    songInfo: {
        flex: 1,
        marginLeft: 12,
    },
    songTitle: {
        fontSize: 16,
        fontWeight: '600',
        color: COLORS.text,
        marginBottom: 4,
    },
    songArtist: {
        fontSize: 14,
        color: COLORS.textSecondary,
    },
});

export default HomeScreen;
