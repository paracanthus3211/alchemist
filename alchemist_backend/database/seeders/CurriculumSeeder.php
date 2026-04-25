<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Chapter;
use App\Models\Level;
use App\Models\Question;

class CurriculumSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // 1. Create Chapter
        $chapter = Chapter::create([
            'title'         => 'Pengenalan Atom',
            'icon_emoji'    => '⚛️',
            'xp_threshold'  => 0,
            'order_index'   => 1,
        ]);

        // 2. Create Levels
        $level1 = Level::create([
            'chapter_id'  => $chapter->id,
            'name'        => 'Struktur Inti Atom',
            'xp_required' => 0,
            'order_index' => 1,
        ]);

        Level::create([
            'chapter_id'  => $chapter->id,
            'name'        => 'Konfigurasi Elektron',
            'xp_required' => 150,
            'order_index' => 2,
        ]);

        // 3. Create Questions for Level 1
        Question::create([
            'level_id'      => $level1->id,
            'type'          => 'MULTIPLE_CHOICE',
            'question_text' => 'Partikel bermuatan positif dalam inti atom disebut...',
            'explanation'   => 'Proton adalah partikel penyusun inti atom yang memiliki muatan listrik positif.',
            'xp_reward'     => 20,
            'order_index'   => 1,
        ]);

        Question::create([
            'level_id'      => $level1->id,
            'type'          => 'SENTENCE_ARRANGEMENT',
            'question_text' => 'Susunlah urutan partikel atom dari yang berada di dalam inti ke luar.',
            'explanation'   => 'Proton dan Neutron berada di dalam inti, sedangkan Elektron berada di kulit atom.',
            'xp_reward'     => 30,
            'order_index'   => 2,
        ]);
    }
}
