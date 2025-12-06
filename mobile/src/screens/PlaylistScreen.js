import React from 'react';
import {
    View,
    Text,
    StyleSheet,
    FlatList,
    TouchableOpacity,
    Image,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { SongData } from '../context/Song';
import { COLORS, SIZES } from '../constants';
import MiniPlayer from '../components/MiniPlayer';

const PlaylistScreen = ({ navigation }) => {
    const { songs, playQueue } = SongData();

    // For now, showing all songs as a playlist
    // In a real app, you'd fetch specific playlist data
    const playlistSongs = songs.slice(0, 10);

    const handlePlayAll = () => {
        if (playlistSongs.length > 0) {
            playQueue(playlistSongs, playlistSongs[0]._id, 'Playlist');
        }
    };

    const handleSongPress = (song) => {
        playQueue(playlistSongs, song._id, 'Playlist');
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
                <TouchableOpacity onPress={() => navigation.goBack()}>
                    <Ionicons name="chevron-back" size={28} color={COLORS.text} />
                </TouchableOpacity>
                <Text style={styles.headerTitle}>Playlist</Text>
                <View style={{ width: 28 }} />
            </View>

            <FlatList
                data={playlistSongs}
                renderItem={renderSongItem}
                keyExtractor={(item) => item._id}
                ListHeaderComponent={
                    <View style={styles.playlistHeader}>
                        <View style={styles.playlistIcon}>
                            <Ionicons name="musical-notes" size={60} color={COLORS.primary} />
                        </View>
                        <Text style={styles.playlistTitle}>My Playlist</Text>
                        <Text style={styles.playlistInfo}>{playlistSongs.length} songs</Text>
                        <TouchableOpacity style={styles.playButton} onPress={handlePlayAll}>
                            <Ionicons name="play" size={24} color={COLORS.background} />
                            <Text style={styles.playButtonText}>Play All</Text>
                        </TouchableOpacity>
                    </View>
                }
                contentContainerStyle={styles.listContent}
            />

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
    headerTitle: {
        fontSize: 18,
        fontWeight: 'bold',
        color: COLORS.text,
    },
    listContent: {
        paddingBottom: 100,
    },
    playlistHeader: {
        alignItems: 'center',
        paddingVertical: 32,
    },
    playlistIcon: {
        width: 200,
        height: 200,
        borderRadius: 12,
        backgroundColor: COLORS.card,
        justifyContent: 'center',
        alignItems: 'center',
        marginBottom: 20,
    },
    playlistTitle: {
        fontSize: 24,
        fontWeight: 'bold',
        color: COLORS.text,
        marginBottom: 8,
    },
    playlistInfo: {
        fontSize: 14,
        color: COLORS.textSecondary,
        marginBottom: 24,
    },
    playButton: {
        flexDirection: 'row',
        alignItems: 'center',
        backgroundColor: COLORS.primary,
        paddingHorizontal: 32,
        paddingVertical: 12,
        borderRadius: 24,
    },
    playButtonText: {
        fontSize: 16,
        fontWeight: 'bold',
        color: COLORS.background,
        marginLeft: 8,
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

export default PlaylistScreen;
