import React, { useEffect, useState } from 'react';
import {
    View,
    Text,
    StyleSheet,
    FlatList,
    TouchableOpacity,
    Image,
    ActivityIndicator,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import api from '../services/api';
import { SongData } from '../context/Song';
import { COLORS, SIZES } from '../constants';
import MiniPlayer from '../components/MiniPlayer';

const AlbumScreen = ({ route, navigation }) => {
    const { id } = route.params;
    const [album, setAlbum] = useState(null);
    const [songs, setSongs] = useState([]);
    const [loading, setLoading] = useState(true);
    const { playQueue } = SongData();

    useEffect(() => {
        fetchAlbum();
    }, [id]);

    const fetchAlbum = async () => {
        try {
            const { data } = await api.get(`/api/song/album/${id}`);
            setAlbum(data.album);
            setSongs(data.songs || []);
        } catch (error) {
            console.error('Error fetching album:', error);
        } finally {
            setLoading(false);
        }
    };

    const handlePlayAll = () => {
        if (songs.length > 0) {
            playQueue(songs, songs[0]._id, album?.title || 'Album');
        }
    };

    const handleSongPress = (song) => {
        playQueue(songs, song._id, album?.title || 'Album');
    };

    const renderSongItem = ({ item, index }) => (
        <TouchableOpacity
            style={styles.songCard}
            onPress={() => handleSongPress(item)}
        >
            <Text style={styles.songNumber}>{index + 1}</Text>
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

    if (loading) {
        return (
            <View style={styles.loadingContainer}>
                <ActivityIndicator size="large" color={COLORS.primary} />
            </View>
        );
    }

    return (
        <SafeAreaView style={styles.container} edges={['top']}>
            <View style={styles.header}>
                <TouchableOpacity onPress={() => navigation.goBack()}>
                    <Ionicons name="chevron-back" size={28} color={COLORS.text} />
                </TouchableOpacity>
                <Text style={styles.headerTitle}>Album</Text>
                <View style={{ width: 28 }} />
            </View>

            <FlatList
                data={songs}
                renderItem={renderSongItem}
                keyExtractor={(item) => item._id}
                ListHeaderComponent={
                    <View style={styles.albumHeader}>
                        <Image
                            source={{ uri: album?.thumbnail?.url || 'https://via.placeholder.com/200' }}
                            style={styles.albumArt}
                        />
                        <Text style={styles.albumTitle}>{album?.title || 'Unknown Album'}</Text>
                        <Text style={styles.albumInfo}>{songs.length} songs</Text>
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
    loadingContainer: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
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
    albumHeader: {
        alignItems: 'center',
        paddingVertical: 32,
    },
    albumArt: {
        width: 200,
        height: 200,
        borderRadius: 12,
        backgroundColor: COLORS.card,
        marginBottom: 20,
    },
    albumTitle: {
        fontSize: 24,
        fontWeight: 'bold',
        color: COLORS.text,
        marginBottom: 8,
        textAlign: 'center',
    },
    albumInfo: {
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
        paddingVertical: 12,
    },
    songNumber: {
        fontSize: 16,
        color: COLORS.textSecondary,
        width: 30,
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

export default AlbumScreen;
