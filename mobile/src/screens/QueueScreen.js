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

const QueueScreen = ({ navigation }) => {
    const { queue, queueIndex, queueLabel, jumpToIndex, removeFromQueue } = SongData();

    const renderSongItem = ({ item, index }) => {
        const isCurrentSong = index === queueIndex;

        return (
            <TouchableOpacity
                style={[styles.songCard, isCurrentSong && styles.currentSongCard]}
                onPress={() => jumpToIndex(index)}
            >
                <Image
                    source={{ uri: item.thumbnail?.url || 'https://via.placeholder.com/50' }}
                    style={styles.songImage}
                />
                <View style={styles.songInfo}>
                    <Text style={[styles.songTitle, isCurrentSong && styles.currentSongText]} numberOfLines={1}>
                        {item.title}
                    </Text>
                    <Text style={styles.songArtist} numberOfLines={1}>
                        {item.singer || 'Unknown Artist'}
                    </Text>
                </View>
                {isCurrentSong && (
                    <Ionicons name="volume-high" size={20} color={COLORS.primary} style={styles.playingIcon} />
                )}
                <TouchableOpacity onPress={() => removeFromQueue(index)}>
                    <Ionicons name="close-circle-outline" size={24} color={COLORS.textSecondary} />
                </TouchableOpacity>
            </TouchableOpacity>
        );
    };

    return (
        <SafeAreaView style={styles.container} edges={['top']}>
            <View style={styles.header}>
                <TouchableOpacity onPress={() => navigation.goBack()}>
                    <Ionicons name="chevron-back" size={28} color={COLORS.text} />
                </TouchableOpacity>
                <View style={styles.headerInfo}>
                    <Text style={styles.title}>Queue</Text>
                    <Text style={styles.subtitle}>{queueLabel}</Text>
                </View>
                <View style={{ width: 28 }} />
            </View>

            <FlatList
                data={queue}
                renderItem={renderSongItem}
                keyExtractor={(item, index) => `${item._id}-${index}`}
                contentContainerStyle={styles.listContent}
                ListEmptyComponent={
                    <View style={styles.emptyContainer}>
                        <Ionicons name="musical-notes-outline" size={64} color={COLORS.textSecondary} />
                        <Text style={styles.emptyText}>No songs in queue</Text>
                    </View>
                }
            />
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
    headerInfo: {
        flex: 1,
        alignItems: 'center',
    },
    title: {
        fontSize: 20,
        fontWeight: 'bold',
        color: COLORS.text,
    },
    subtitle: {
        fontSize: 12,
        color: COLORS.textSecondary,
        marginTop: 2,
    },
    listContent: {
        paddingBottom: 20,
    },
    songCard: {
        flexDirection: 'row',
        alignItems: 'center',
        paddingHorizontal: SIZES.padding,
        paddingVertical: 8,
    },
    currentSongCard: {
        backgroundColor: COLORS.card,
    },
    songImage: {
        width: 50,
        height: 50,
        borderRadius: 6,
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
    currentSongText: {
        color: COLORS.primary,
    },
    songArtist: {
        fontSize: 14,
        color: COLORS.textSecondary,
    },
    playingIcon: {
        marginRight: 12,
    },
    emptyContainer: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        paddingTop: 100,
    },
    emptyText: {
        fontSize: 16,
        color: COLORS.textSecondary,
        marginTop: 16,
    },
});

export default QueueScreen;
