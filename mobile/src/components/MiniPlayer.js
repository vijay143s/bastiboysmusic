import React from 'react';
import {
    View,
    Text,
    StyleSheet,
    TouchableOpacity,
    Image,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { SongData } from '../context/Song';
import { COLORS, SIZES } from '../constants';

const MiniPlayer = ({ navigation }) => {
    const { song, isPlaying, togglePlayPause, nextMusic } = SongData();

    if (!song) return null;

    return (
        <TouchableOpacity
            style={styles.container}
            onPress={() => navigation.navigate('Player')}
            activeOpacity={0.9}
        >
            <Image
                source={{ uri: song.thumbnail?.url || 'https://via.placeholder.com/50' }}
                style={styles.thumbnail}
            />
            <View style={styles.info}>
                <Text style={styles.title} numberOfLines={1}>
                    {song.title}
                </Text>
                <Text style={styles.artist} numberOfLines={1}>
                    {song.singer || 'Unknown Artist'}
                </Text>
            </View>
            <TouchableOpacity
                onPress={(e) => {
                    e.stopPropagation();
                    togglePlayPause();
                }}
                style={styles.playButton}
            >
                <Ionicons
                    name={isPlaying ? 'pause' : 'play'}
                    size={28}
                    color={COLORS.text}
                />
            </TouchableOpacity>
            <TouchableOpacity
                onPress={(e) => {
                    e.stopPropagation();
                    nextMusic('manual');
                }}
                style={styles.nextButton}
            >
                <Ionicons name="play-skip-forward" size={24} color={COLORS.text} />
            </TouchableOpacity>
        </TouchableOpacity>
    );
};

const styles = StyleSheet.create({
    container: {
        position: 'absolute',
        bottom: SIZES.tabBarHeight,
        left: 0,
        right: 0,
        height: SIZES.miniPlayerHeight,
        backgroundColor: COLORS.card,
        borderTopWidth: 1,
        borderTopColor: COLORS.border,
        flexDirection: 'row',
        alignItems: 'center',
        paddingHorizontal: SIZES.padding,
    },
    thumbnail: {
        width: 50,
        height: 50,
        borderRadius: 6,
        backgroundColor: COLORS.background,
    },
    info: {
        flex: 1,
        marginLeft: 12,
    },
    title: {
        fontSize: 14,
        fontWeight: '600',
        color: COLORS.text,
        marginBottom: 4,
    },
    artist: {
        fontSize: 12,
        color: COLORS.textSecondary,
    },
    playButton: {
        marginRight: 8,
    },
    nextButton: {
        marginLeft: 8,
    },
});

export default MiniPlayer;
